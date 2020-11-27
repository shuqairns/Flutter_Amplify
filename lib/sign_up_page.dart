import 'package:flutter/material.dart';
import 'package:flutter_amplify/auth_credentials.dart';

import 'analytics_events.dart';
import 'analytics_service.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;
  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 40),
      child: Stack(children: [
        //Sign Up form
        _signUpForm(),

        //Login Button
        Container(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: widget.shouldShowLogin,
            child: Text('Already have an account? Login.'),
          ),
        )
      ]),
    ));
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
        ),
        // Email Textfield
        TextField(
          controller: _emailController,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        //Sign up button
        FlatButton(
          onPressed: _signUp,
          child: Text('Sign up'),
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');

    final credentials =
        SignUpCredentials(username: username, password: password, email: email);
    widget.didProvideCredentials(credentials);
    AnalyticsService.log(SignUpEvent());
  }
}
