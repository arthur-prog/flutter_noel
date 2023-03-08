import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/product/add_product/add_product_controller.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VariantFormWidget extends StatelessWidget {
  VariantFormWidget({
    super.key,
  });

  final _controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.color),
                value: _controller.isColorSelected.value,
                onChanged: (value) => _controller.changeIsColorSelected(value!),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: primaryColor,
                enabled: _controller.variants.isEmpty ? true : false,
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.size),
                value: _controller.isSizeSelected.value,
                onChanged: (value) => _controller.changeIsSizeSelected(value!),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: primaryColor,
                enabled: _controller.variants.isEmpty ? true : false,
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.sameImage),
                value: _controller.isSameImageSelected.value,
                onChanged: (value) => _controller.isSameImageSelected(value!),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: primaryColor,
                enabled: _controller.variants.isEmpty ? true : false,
              ),
            ),
          ),
          if (_controller.variants.isNotEmpty) const Divider(),
          const SizedBox(height: 10.0),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: _controller.variants.length * 60.0,
              child: ListView.builder(
                  itemCount: _controller.variants.length,
                  itemBuilder: (context, index) {
                    Variant variant = _controller.variants[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                                () => _controller.variantImages.isNotEmpty
                                    ? !_controller.isSameImageSelected.value
                                    ? _controller.variantImages.length > index && _controller.variantImages[_controller.variants[index].id] != null
                                    ? Image.file(
                                      _controller.variantImages[_controller.variants[index].id]!,
                                      width: 50.0,
                                      height: 50.0,
                                    ) : const NoImageWidget(height: 50, width: 50)
                                    : const SizedBox(height: 50, width: 50)
                                    : const SizedBox(height: 50, width: 50),
                            ),
                            if (_controller.isSizeSelected.value)
                              Text(
                                '${variant.size}',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            if (_controller.isColorSelected.value)
                              Text(
                                '${variant.color}',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            Text(
                              '${variant.price}€',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            IconButton(
                              onPressed: () => _controller.modifyVariant(index),
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _controller.removeVariant(index),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  }),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _controller.addVariant(),
              child: Text(
                AppLocalizations.of(context)!.addVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
