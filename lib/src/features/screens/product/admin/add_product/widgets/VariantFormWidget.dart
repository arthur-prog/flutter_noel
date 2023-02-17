import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/product/add_product/add_product_controller.dart';
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
          Column(
            children: [
              Obx(
              () => SizedBox(
                width: double.infinity,
                child: CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.color),
                    value: _controller.isColorSelected.value,
                    onChanged: (value) =>
                        _controller.changeIsColorSelected(value!),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor,
                  ),
              ),
              ),
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  child: CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.size),
                    value: _controller.isSizeSelected.value,
                    onChanged: (value) =>
                        _controller.changeIsSizeSelected(value!),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          // ListView.builder(
          //     itemCount: _controller.variantParametersController.length,
          //     itemBuilder: (context, index) {
          //       return Row(
          //         children: [
          //           TextField(
          //             controller: _controller.variantParametersController[index],
          //           ),
          //         ],
          //       );
          //     }),
        ],
      ),
    );
  }
}
