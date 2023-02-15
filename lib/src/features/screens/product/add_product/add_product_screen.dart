import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/category.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/product/add_product/add_product_controller.dart';
import 'package:flutter_noel/src/features/screens/product/add_product/VariantFormWidget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddProductScreen extends StatelessWidget {
  AddProductScreen({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
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
                      AppLocalizations.of(context)!.addProduct,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) =>
                              _controller.validateName(value!),
                          controller: _controller.nameController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.productName,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) =>
                              _controller.validateDescription(value!),
                          controller: _controller.descriptionController,
                          minLines: 3,
                          maxLines: 10,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .productDescription,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          validator: (value) =>
                              _controller.validateCategory(value),
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.productCategory,
                          ),
                          items: categoryDropdownItemList,
                          onChanged: (value) =>
                              _controller.changeCategory(value),
                        ),
                        Obx(
                              () => CheckboxListTile(
                            title: Text(AppLocalizations.of(context)!
                                .productWithVariant),
                            value: _controller.isVariable.value,
                            onChanged: (value) =>
                                _controller.changeIsVariable(value!),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: primaryColor,
                          ),
                        ),
                        Obx(() => !_controller.isVariable.value ?
                        TextFormField(
                          validator: (value) =>
                              _controller.validatePrice(value!),
                          controller: _controller.priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffix: const Text("€"),
                            labelText:
                            AppLocalizations.of(context)!.productPrice,
                          ),
                        ) : VariantFormWidget(controller: _controller)),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _controller.addProduct(),
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
