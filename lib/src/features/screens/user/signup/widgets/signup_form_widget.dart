import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/features/controllers/user/registration_user/registration_user_controller.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationUserController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) => controller.validateName(value!),
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userName,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateSurname(value!),
              controller: controller.surnameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userSurname,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateEmail(value!),
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userEmail,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateHouseNumber(value!),
              controller: controller.houseNumberController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userHouseNumber,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateStreet(value!),
              controller: controller.streetController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userStreet,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateCity(value!),
              controller: controller.cityController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userCity,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validateCP(value!),
              controller: controller.CPController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userPostCode,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => controller.validatePassword(value!),
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userPassword,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addUser(),
                child: Text(
                  AppLocalizations.of(context)!.validate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
