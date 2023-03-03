import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/controllers/user/modify_adress_user/modify_adress_user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModifyUserAdressScreen extends StatelessWidget {
  ModifyUserAdressScreen({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(ModifyUserAdressController());


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Adress'),
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
                  if (user != null)
                    Text("Vous êtes connecté en tant que ${user.displayName}"),
                  TextFormField(
                    validator: (value) =>
                        _controller.validateCP(value!),
                    controller: _controller.CPController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .userPostCode,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _controller.modifyUserAdress(),
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
