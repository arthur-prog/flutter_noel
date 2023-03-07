import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/controllers/product_searched/product_searched_controller.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:flutter_noel/src/features/controllers/product/products_list/products_list_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Card(
            child: TextField(
              controller: _controller.productController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {_controller.back();},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
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
