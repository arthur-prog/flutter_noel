import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/user/edit_profile/edit_profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(EditProdileController());


  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
        title: Text(
          AppLocalizations.of(context)!.editProfile,
        ),
      ),
      body: SingleChildScrollView(
        child:
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        _controller.validateFirstName(value!),
                    controller: _controller.firstNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .firstName,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        _controller.validateLastName(value!),
                    controller: _controller.lastNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .lastName,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _controller.updateProfile(),
                      child: Text(
                        AppLocalizations.of(context)!.validate,
                      ),
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
