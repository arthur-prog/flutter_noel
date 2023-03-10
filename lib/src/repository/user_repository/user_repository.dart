import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserData?> getUserById(String userId) async {
    try {
      final result = await usersCollection.doc(userId).get();
      final userJson = result.data() as Map<String, dynamic>;
      return UserData.fromMap(userJson);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addUser(UserData user) async {
    final userDoc = usersCollection.doc(user.id);
    await userDoc
        .set(user.toMap())
        .whenComplete(
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.createdAccount,
        title: AppLocalizations.of(Get.context!)!.success,
        type: "success",
      ),
    )
        .catchError((error, stackTrace) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    });
  }

  Future<void> updateUser(UserData user) async {
    final userDoc = usersCollection.doc(user.id);
    await userDoc
        .update(user.toMap())
        .whenComplete(
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.updatedAccount,
        title: AppLocalizations.of(Get.context!)!.success,
        type: "success",
      ),
    )
        .catchError((error, stackTrace) {
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    });
  }


}
