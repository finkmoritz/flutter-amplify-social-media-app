import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class LoginService {
  static Future<SignInResult> signIn({String username, String password}) {
    var request = SignInRequest(
      username: username,
      password: password,
    );
    return AmplifyAuthCognito().signIn(request: request);
  }

  static Future<SignUpResult> signUp(
      {String email, String username, String password}) {
    Map<String, String> userAttributes = {'email': email};
    var request = SignUpRequest(
        username: username,
        password: password,
        options: SignUpOptions(userAttributes: userAttributes));
    return AmplifyAuthCognito().signUp(request: request);
  }

  static Future<SignUpResult> confirmSignUp({String username, String confirmationCode}) {
    var request = ConfirmSignUpRequest(
        username: username, confirmationCode: confirmationCode);
    return AmplifyAuthCognito().confirmSignUp(request: request);
  }
}
