import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SignInWithEmailAndPasswordFailure {
  final String message;

  const SignInWithEmailAndPasswordFailure([this.message = "An Unknown Error Occurred"]);

  factory SignInWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'invalid-email':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.invalidEmailException);
      case 'wrong-password':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.wrongPasswordException);
      case 'user-not-found':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.userNotFoundException);
      case 'too-many-requests':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.tooManyRequestsException);
      case 'operation-not-allowed':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.operationNotAllowedException);
      case 'user-disabled':
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.userDisabledException);
      default:
        return SignInWithEmailAndPasswordFailure(AppLocalizations.of(Get.context!)!.somethingWentWrong);
    }
  }
}