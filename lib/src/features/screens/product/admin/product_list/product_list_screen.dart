import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/images.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';

//add dev
class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  final _productRepository = Get.put(ProductRepository());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
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
                      Text("no partys"),
                    ];
                  } else {
                    productsSnapshot.data!.docs.forEach((doc) {
                      Map<String, dynamic> productJson = doc.data();
                      Product product = Product.fromMap(productJson);
                      children.add(
                        Row(
                          children: [
                            FutureBuilder(
                              future: getImage(product.urlPicture),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListTile(
                                title: Text(product.name),
                                subtitle: Text(product.price.toString()),
                              ),
                            )
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
