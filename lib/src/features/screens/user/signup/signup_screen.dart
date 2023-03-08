import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/form/form_footer_widget.dart';
import 'package:flutter_noel/src/common_widgets/form/form_header_widget.dart';
import 'package:flutter_noel/src/features/screens/user/login/login_screen.dart';
import 'package:flutter_noel/src/features/screens/user/signup/widgets/signup_form_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final platformBrightness = mediaQuery.platformBrightness;

    return SafeArea(
      child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormHeaderWidget(
                  title: AppLocalizations.of(context)!.signUpTitle,
                  subTitle: AppLocalizations.of(context)!.signUpSubTitle,
                ),
                const SignUpFormWidget(),
                FooterFormWidget(
                  platformBrightness: platformBrightness,
                  text1: AppLocalizations.of(context)!.alreadyHaveAccount,
                  text2: AppLocalizations.of(context)!.login,
                  redirection: () => (Get.to(() => const LoginScreen())),
                )
              ],
            ),
        ),
      ),
          )),
    );
  }
}
