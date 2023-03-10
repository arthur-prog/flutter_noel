import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/user/product_user/product_user_controller.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/user/cart/Widgets/ProductLineWidget.dart';
import 'package:flutter_noel/src/repository/cart_repository/cart_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductUserScreen extends StatelessWidget {
  ProductUserScreen({Key? key}) : super(key: key);

  final _cartRepository = Get.put(CartRepository());

  final _controller = Get.put(ProductUserController());


  @override
  Widget build(BuildContext context) {
    List<double> total=[];
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
          title: Text(AppLocalizations.of(context)!.cart),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder(
                stream: _cartRepository.getCartProductsSnapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot productsSnapshot) {
                      total = _cartRepository.calculTotal(productsSnapshot);

                      List<Widget> children = [];
                  if (productsSnapshot.hasData) {
                    if (productsSnapshot.data!.docs.isEmpty) {
                      return const Text("no product");
                    } else {
                      productsSnapshot.data!.docs.forEach((doc) {
                        Map<String, dynamic> productJson = doc.data();
                        CartProduct cartProduct = CartProduct.fromMap(productJson);
                        children.add(
                          ProductLineWidget(
                              cartProduct: cartProduct,
                              onDecrementQuantity: () =>
                                  _controller.decrementQuantity(cartProduct),
                              onIncrementQuantity: () =>
                                  _controller.incrementQuantity(cartProduct)),
                        );
                      });
                      children.add(const SizedBox(
                        height: 10,
                      ));
                      children.add(Text("Price: ${total[1].toString()}€"));
                      children.add(Text("Fizz: ${total[2].toString()}€"));
                      children.add(Text("Total: ${total[0].toString()}€"));
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: children,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {_cartRepository.validateOrder(total[0]);},
                    child: Text(
                      AppLocalizations.of(context)!.pay,
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
