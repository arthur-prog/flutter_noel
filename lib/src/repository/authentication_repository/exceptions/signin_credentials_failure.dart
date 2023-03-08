import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SignInWithCredentialsFailure {
  final String message;

  const SignInWithCredentialsFailure([this.message = "An Unknown Error Occurred"]);

  factory SignInWithCredentialsFailure.code(String code){
    switch(code){
      case 'invalid-credentials':
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.invalidCredentialsException);
      case 'user-disabled':
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.userDisabledException);
      case 'account-exists-with-different-credential':
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.accountExistsWithDifferentCredentialException);
      case 'operation-not-allowed':
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.operationNotAllowedException);
      case 'invalid-action-code':
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.invalidActionCodeException);
      default:
        return SignInWithCredentialsFailure(AppLocalizations.of(Get.context!)!.somethingWentWrong);
    }
  }
}