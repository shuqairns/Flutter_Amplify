import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_amplify/auth_credentials.dart';

//1
enum AuthFlowStatus { login, signUp, verification, session }

// 2
class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

// 3
class AuthService {
  // 4
  final authStateController = StreamController<AuthState>();

  AuthCredentials _credentials;

  // 5
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  //6
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(
          username: credentials.username, password: credentials.password);
      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        print('User could not be signed in');
      }
    } on AuthError catch (authError) {
      print('Couldn\'t login - ${authError.cause}');
    }
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {'email': credentials.email};

      final result = await Amplify.Auth.signUp(
          username: credentials.username,
          password: credentials.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));

      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        this._credentials = credentials;

        final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
        authStateController.add(state);
      }
    } on AuthError catch (authError) {
      print('Failed to sign up - ${authError.cause}');
    }
  }

  void verifyCode(String verificationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: _credentials.username, confirmationCode: verificationCode);

      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {
        //follow more steps
      }
    } on AuthError catch (authError) {
      print('Couldn\'t verify code - ${authError.cause}');
    }
  }

  void logOut() async {
    try {
      await Amplify.Auth.signOut();
      showLogin();
    } on AuthError catch (authError) {
      print('Could not log out - ${authError.cause}');
    }
  }

  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }
}
