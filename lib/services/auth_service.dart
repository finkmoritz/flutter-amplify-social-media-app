import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthService {
  static Future<bool> isSignedIn() async {
    try {
      var user = await Amplify.Auth.getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  static Future<SignInResult> signIn({String username, String password}) async {
    await Amplify.Auth.signOut();
    var result =
        await Amplify.Auth.signIn(username: username, password: password);
    Amplify.Analytics.recordEvent(event: AnalyticsEvent('signIn'));
    return result;
  }

  static Future<SignOutResult> signOut() async {
    return Amplify.Auth.signOut();
  }

  static Future<SignUpResult> signUp({String email, String username, String password}) async {
    var result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(userAttributes: {'email': email}));
    Amplify.Analytics.recordEvent(event: AnalyticsEvent('signUp'));
    return result;
  }

  static Future<SignUpResult> confirmSignUp({String username, String confirmationCode}) async {
    var result = await Amplify.Auth.confirmSignUp(
        username: username, confirmationCode: confirmationCode);
    Amplify.Analytics.recordEvent(event: AnalyticsEvent('confirmSignUp'));
    return result;
  }

  static Future<ResendSignUpCodeResult> resendConfirmationCode({String username}) {
    return Amplify.Auth.resendSignUpCode(username: username);
  }

  static Future<ResetPasswordResult> resetPassword({String username}) {
    return Amplify.Auth.resetPassword(username: username);
  }

  static Future<UpdatePasswordResult> confirmPasswordReset({String username, String newPassword, String confirmationCode}) {
    return Amplify.Auth.confirmPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode);
  }

  static Future<UpdatePasswordResult> changePassword({String oldPassword, String newPassword}) {
    return Amplify.Auth.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
