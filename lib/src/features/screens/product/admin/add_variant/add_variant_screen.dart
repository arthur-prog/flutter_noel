import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/images.dart';
import 'package:flutter_noel/src/features/controllers/product/add_variant/add_variant_controller.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddVariantScreen extends StatelessWidget {
  AddVariantScreen({
    Key? key,
    required this.size,
    required this.color,
    required this.sameImage,
    this.variant,
    this.image,
  }) : super(key: key);

  final _controller = Get.put(AddVariantController());

  late Variant? variant;
  late File? image;
  final bool size;
  final bool color;
  final bool sameImage;

  @override
  Widget build(BuildContext context) {
    _controller.addValues(variant, image);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      variant == null
                          ? AppLocalizations.of(context)!.addVariant
                          : AppLocalizations.of(context)!.editVariant,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  if (!sameImage)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: _controller.image.value == null
                          ? NoImageWidget(height: MediaQuery.of(context).size.height *  0.3, width: MediaQuery.of(context).size.width *  0.7)
                          : SizedBox(
                        height: MediaQuery.of(context).size.height *  0.3,
                        child: Obx(() => Image.file(_controller.image.value!)),
                      )
                    ),
                  ),
                  if (!sameImage)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _controller.selectImage,
                        child: Text(AppLocalizations.of(context)!.addPhoto)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _controller.formKey,
                    child: Column(
                      children: [
                        if (size)
                        TextFormField(
                          validator: (value) =>
                              _controller.validateSize(value!),
                          controller: _controller.sizeController,
                          decoration: InputDecoration(
                            labelText:
                            AppLocalizations.of(context)!.size,
                          ),
                        ),
                        if (size)
                        const SizedBox(
                          height: 20,
                        ),
                        if (color)
                        TextFormField(
                          validator: (value) =>
                              _controller.validateColor(value!),
                          controller: _controller.colorController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .color,
                          ),
                        ),
                        if (color)
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) =>
                              _controller.validatePrice(value!),
                          controller: _controller.priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffix: const Text("€"),
                            labelText: AppLocalizations.of(context)!
                                .productPrice,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _controller.addVariant(),
                            child: Text(
                              AppLocalizations.of(context)!.validate,
                            ),
                          ),
                        ),
                      ],
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
