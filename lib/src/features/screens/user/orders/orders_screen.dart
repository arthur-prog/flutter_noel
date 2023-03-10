import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_noel/src/repository/order_repository/order_repository.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final _orderRepository = Get.put(OrderRepository());

  final _authRepo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = _authRepo.firebaseUser.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
          title: Text(AppLocalizations.of(context)!.orders),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: _orderRepository.getOrdersSnapshots(user!.uid),
            builder: (BuildContext context, AsyncSnapshot productsSnapshot) {
              List<Widget> children = [];
              if (productsSnapshot.hasData) {
                if (productsSnapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(AppLocalizations.of(context)!.noOrders));
                } else {
                  productsSnapshot.data!.docs.asMap().forEach((index, doc) {
                    Map<String, dynamic> orderJson = doc.data();
                    double totalPrice = orderJson['totalPrice'];

                    children.add(Text("Total: ${totalPrice.toString()}€"));
                    children.add(const SizedBox(height: 10));
                    children.add(FutureBuilder(
                      future:
                          _orderRepository.getOrderProducts(user.uid, doc.id),
                      builder: (BuildContext context,
                          AsyncSnapshot orderProductsSnapshot) {
                        if (orderProductsSnapshot.hasData) {
                          List<Widget> thisChildren = [];
                          orderProductsSnapshot.data!.docs.forEach((thisDoc) {
                            Product product =
                                Product.fromMap(thisDoc.data()["product"]);
                            int quantity = thisDoc.data()["quantity"];
                            thisChildren.add(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder(
                                  future: getImageUrl(product.urlPicture),
                                    builder: (context, asyncSnapshot) {
                                      if (asyncSnapshot.hasData) {
                                        return Image.network(
                                          asyncSnapshot.data.toString(),
                                          width: 100,
                                          height: 100,
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                ),
                                const SizedBox(width: 10),
                                Text(product.name),
                                const SizedBox(width: 10),
                                Text("Quantité: ${quantity.toString()}")
                              ],
                            ));
                          });
                          return Column(
                            children: thisChildren,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ));
                    if(index != productsSnapshot.data!.docs.length - 1) {
                      children.add(const SizedBox(height: 10));
                      children.add(Divider());
                      children.add(const SizedBox(height: 10));
                    }
                  });
                }
              } else {
                return const CircularProgressIndicator();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}
