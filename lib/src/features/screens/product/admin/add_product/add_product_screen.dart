import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/category.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/constants/images.dart';
import 'package:flutter_noel/src/features/controllers/product/add_product/add_product_controller.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/product/admin/add_product/widgets/VariantFormWidget.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  late Product? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void dispose() {
    Get.delete<AddProductController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(AddProductController());
    _controller.addValues(widget.product);
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
                      widget.product == null
                          ? AppLocalizations.of(context)!.addProduct
                          : AppLocalizations.of(context)!.updateProduct,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Obx(
                    () => !_controller.isVariable.value || (_controller.isVariable.value && _controller.isSameImageSelected.value)
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                                child: Obx(() => _controller.image.value == null
                                    ? widget.product == null ||
                                            widget.product!.urlPicture == ""
                                        ? NoImageWidget(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          )
                                        : FutureBuilder(
                                            future:
                                                getImageUrl(widget.product!.urlPicture),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Image.network(
                                                      snapshot.data.toString()),
                                                );
                                              }
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          )
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Image.file(
                                            _controller.image.value!),
                                      ))),
                          ) : const SizedBox() ,
                  ),
                  Obx(
                    () => !_controller.isVariable.value || (_controller.isVariable.value && _controller.isSameImageSelected.value)
                        ? ElevatedButton(
                            onPressed: _controller.selectImage,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(AppLocalizations.of(context)!.addPhoto),
                            )) : const SizedBox(),
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
                          value: widget.product == null
                              ? null
                              : _controller.categoryController.text,
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
                        Obx(() => !_controller.isVariable.value
                            ? TextFormField(
                                validator: (value) =>
                                    _controller.validatePrice(value!),
                                controller: _controller.priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffix: const Text("€"),
                                  labelText: AppLocalizations.of(context)!
                                      .productPrice,
                                ),
                              )
                            : VariantFormWidget()),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => widget.product == null
                                ? _controller.addProduct()
                                : _controller.updateProduct(),
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
