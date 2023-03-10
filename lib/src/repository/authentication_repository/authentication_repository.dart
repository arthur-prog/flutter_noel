import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:flutter_noel/src/features/screens/product/products_list/products_list_screen.dart';
import 'package:flutter_noel/src/repository/authentication_repository/exceptions/signin_credentials_failure.dart';
import 'package:flutter_noel/src/repository/authentication_repository/exceptions/signin_email_password_failure.dart';
import 'package:flutter_noel/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/features/models/User.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => ProductsListScreen(isConnected: false))
        : Get.offAll(() => const HomeScreen());
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      UserData user = UserData(
        id: firebaseUser.value!.uid,
        email: firebaseUser.value!.email!,
        isAdmin: false,
      );
      final checkUser = await _userRepo.getUserById(user.id);
      if (checkUser == null) {
        _userRepo.addUser(user);
      }
      firebaseUser.value == null
          ? Get.offAll(() => ProductsListScreen(isConnected: false))
          : Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithCredentialsFailure.code(e.code);
      SnackBarInformationWidget(
        text: ex.message,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
    } on PlatformException catch (e) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(e.toString());
    }
  }

  void createUserWithEmailandPassword(
      String password, UserData userdata) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
              email: userdata.email,
              password: password
          );
      userdata.id = userCredential.user!.uid;
      _userRepo.addUser(userdata);
      firebaseUser.value == null
          ? Get.offAll(() => ProductsListScreen(isConnected: false))
          : Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      SnackBarInformationWidget(
        text: ex.message,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
    } catch (_) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
    }
  }

  void signInWithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value == null
          ? Get.offAll(() => ProductsListScreen(isConnected: false))
          : Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithEmailAndPasswordFailure.code(e.code);
      SnackBarInformationWidget(
        text: ex.message,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
    } catch (_) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
    }
  }

  Future<void> logOut() async => await _auth.signOut();
}
