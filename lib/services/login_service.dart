import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class LoginService {
  static Future<SignUpResult> signUp(
      {String email, String username, String password}) {
    var options = SignUpOptions(userAttributes: {
      'email': email,
    });
    var request =
        SignUpRequest(username: username, password: password, options: options);
    return AmplifyAuthCognito().signUp(request: request);
  }

  static Future<SignUpResult> confirmSignUp(
      {String username, String confirmationCode}) {
    var request = ConfirmSignUpRequest(
        username: username, confirmationCode: confirmationCode);
    return AmplifyAuthCognito().confirmSignUp(request: request);
  }
}
