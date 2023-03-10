import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/controllers/user/favorite_user/favorite_user_controller.dart';
import 'package:flutter_noel/src/features/controllers/user/product_user/product_user_controller.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/cart_repository/cart_repository.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:flutter_noel/src/features/controllers/product/products_list/products_list_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//add dev
class ProductUserScreen extends StatelessWidget {
  ProductUserScreen({Key? key}) : super(key: key);

  final _cartRepository = Get.put(CartRepository());

  final _controller = Get.put(ProductUserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Liste favoris', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black)),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: _cartRepository.getCartProductsSnapshots(),
                builder: (BuildContext context, AsyncSnapshot productsSnapshot) {
                  List<Widget> children = [];
                  if (productsSnapshot.hasData) {
                    if (productsSnapshot.data!.docs.isEmpty) {
                      return const Text("no product");
                    } else {
                      productsSnapshot.data!.docs.forEach((doc) {
                        Map<String, dynamic> productJson = doc.data();
                        CartProduct cartProduct = CartProduct.fromMap(productJson);
                        Product? product = cartProduct.product;
                        children.add(
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(product?.name ?? ''),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {print(cartProduct.id);
                                  _controller.removeProductFromCart(cartProduct);
                                  },
                                  child: Text('Remove'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {print(cartProduct.id);
                                  _controller.incrementQuantity(cartProduct);
                                  },
                                  child: Text('+'),
                                ),
                                Text('quantity : ' + cartProduct.quantity.toString()),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {print(cartProduct.id);
                                  _controller.decrementQuantity(cartProduct);
                                  },
                                  child: Text('-'),
                                ),
                              ],
                            ),
                          ),

                        );
                      });
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1
                            ),
                            children: children
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}
