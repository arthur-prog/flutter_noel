import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/controllers/user/registration_user/registration_user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationUserScreen extends StatelessWidget {
  RegistrationUserScreen({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(RegistrationUserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child:
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) =>
                          _controller.validateName(value!),
                      controller: _controller.nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userName,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateSurname(
                              value!),
                      controller: _controller.surnameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userSurname,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateEmail(value!),
                      controller: _controller.emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userEmail,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateHouseNumber(value!),
                      controller: _controller.houseNumberController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userHouseNumber,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateStreet(value!),
                      controller: _controller.streetController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userStreet,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateCity(value!),
                      controller: _controller.cityController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userCity,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validateCP(value!),
                      controller: _controller.CPController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userPostCode,
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          _controller.validatePassword(value!),
                      controller: _controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .userPassword,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _controller.addUser(),
                      child: Text(
                        AppLocalizations.of(context)!.validate,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
