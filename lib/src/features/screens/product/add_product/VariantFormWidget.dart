import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/controllers/product/add_product/add_product_controller.dart';

class VariantFormWidget extends StatelessWidget {
  const VariantFormWidget({
    super.key,
    required AddProductController controller,
  }) : _controller = controller;

  final AddProductController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.2),
      ),
      child: ListView.builder(
          itemCount: _controller.variants.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("ok"),
            );
          }),
    );
  }
}
