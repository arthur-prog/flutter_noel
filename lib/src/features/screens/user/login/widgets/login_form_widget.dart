import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/features/controllers/user/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) => controller.validateEmail(value!),
              controller: controller.emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: AppLocalizations.of(context)!.userEmail,
                hintText: AppLocalizations.of(context)!.userEmail,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => TextFormField(
                validator: (value) => controller.validatePassword(value!),
                controller: controller.passwordController,
                obscureText: controller.isPasswordNotVisible.value,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: AppLocalizations.of(context)!.userPassword,
                    hintText: AppLocalizations.of(context)!.userPassword,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => controller.changePasswordVisibility(),
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()  => controller.loginUser(),
                child: Text(AppLocalizations.of(context)!.login.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
