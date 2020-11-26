const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:2e7d2157-8a6a-477e-a62d-58dafbf7bbc3",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_zUk4Qk0U9",
                        "AppClientId": "7k0igh1p2n84jhi31434ec8oo6",
                        "AppClientSecret": "ten56u8ef36tn9h91hbkcdl6b5u14evbge8mtegu83qtmugpd4a",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "flutterapptest205450-dev",
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "flutterapptest205450-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';