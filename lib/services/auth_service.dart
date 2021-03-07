import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthService {
  static Future<SignInResult> signIn({String username, String password}) async {
    await Amplify.Auth.signOut();
    return Amplify.Auth.signIn(username: username, password: password);
  }

  static Future<SignUpResult> signUp(
      {String email, String username, String password}) {
    Map<String, String> userAttributes = {'email': email};
    return Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes));
  }

  static Future<SignUpResult> confirmSignUp(
      {String username, String confirmationCode}) {
    return Amplify.Auth.confirmSignUp(
        username: username, confirmationCode: confirmationCode);
  }

  static Future<ResendSignUpCodeResult> resendConfirmationCode(
      {String username}) {
    return Amplify.Auth.resendSignUpCode(username: username);
  }

  static Future<ResetPasswordResult> resetPassword({String username}) {
    return Amplify.Auth.resetPassword(username: username);
  }

  static Future<UpdatePasswordResult> confirmPasswordReset(
      {String username, String newPassword, String confirmationCode}) {
    return Amplify.Auth.confirmPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode);
  }

  static Future<UpdatePasswordResult> changePassword(
      {String oldPassword, String newPassword}) {
    return Amplify.Auth.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
