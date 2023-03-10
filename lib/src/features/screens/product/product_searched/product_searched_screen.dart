import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/product_searched/product_searched_controller.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//add dev
class ProductSearchedScreen extends StatefulWidget {
  ProductSearchedScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchedScreen> createState() => _ProductSearchedScreenState();
}

class _ProductSearchedScreenState extends State<ProductSearchedScreen> {
  final _controller = Get.put(ProductSearchedController());

  final _productRepository = Get.put(ProductRepository());

  void initState() {
    _controller.productController.addListener(() {
      _controller.productStream.add(_controller.productController.text);
    });
    super.initState();
  }

  void dispose() {
    _controller.productStream.close();
    _controller.productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: Card(
            child: TextField(
              controller: _controller.productController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {_controller.back();},
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? lightColor : darkColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: _controller.productStream.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    String productSearched = snapshot.data!;
                    return FutureBuilder(
                      future: _productRepository.getProductsStartsByProductName(productSearched),
                      builder: (BuildContext context, AsyncSnapshot snapshotProducts){
                        if(snapshotProducts.connectionState == ConnectionState.done){
                          if (snapshotProducts.hasData){
                            return _controller.buildProducts(_controller, context, snapshotProducts.data!);
                          } else {
                            return Text(productSearched);
                          }
                        }
                        return Text(productSearched);
                      }
                    );
                  }
                  return Container();
                },
              ),
            )
        ),
      ),
    );
  }
}
