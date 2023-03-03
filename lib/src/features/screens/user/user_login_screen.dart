import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/controllers/user/login_user/login_user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginUserScreen extends StatelessWidget {
  LoginUserScreen({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(LoginUserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) =>
                      _controller.validateEmail(value!),
                  controller: _controller.emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                        .userEmail,
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _controller.loginUser(),
                  child: Text(
                    AppLocalizations.of(context)!.validate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
