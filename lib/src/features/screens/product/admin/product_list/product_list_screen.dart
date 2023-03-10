import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/product/admin/add_product/add_product_screen.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  final _productRepository = Get.put(ProductRepository());

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
          title: Text(AppLocalizations.of(context)!.products),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => AddProductScreen());
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: _productRepository.getProductsSnapshots(),
              builder: (BuildContext context, AsyncSnapshot productsSnapshot) {
                List<Widget> children = [];
                if (productsSnapshot.hasData) {
                  if (productsSnapshot.data!.docs.isEmpty) {
                    children = <Widget>[
                      Text("no products"),
                    ];
                  } else {
                    productsSnapshot.data!.docs.forEach((doc) {
                      Map<String, dynamic> productJson = doc.data();
                      Product product = Product.fromMap(productJson);
                      children.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: FutureBuilder(
                                future: getImageUrl(product.urlPicture),
                                builder: (BuildContext context,
                                    AsyncSnapshot imageSnapshot) {
                                  if (imageSnapshot.connectionState ==
                                      ConnectionState.done){
                                    if (imageSnapshot.hasData) {
                                      return Image.network(
                                        imageSnapshot.data,
                                        width: 100,
                                        height: 100,
                                      );
                                    } else {
                                      return const NoImageWidget(height: 100, width: 100);
                                    }
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(product.name),
                                    if(product.price != null)
                                      Text(product.price.toString()),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => AddProductScreen(
                                        product: product,
                                      ));
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  _productRepository.deleteProduct(product.id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                } else {
                  children = <Widget>[
                    const CircularProgressIndicator(),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}
