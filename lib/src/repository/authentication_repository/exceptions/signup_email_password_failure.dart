import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown Error Occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.weakPasswordException);
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.invalidEmailException);
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.emailAlreadyInUseException);
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.operationNotAllowedException);
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.userDisabledException);
      default:
        return SignUpWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.somethingWentWrong);
    }
  }
}