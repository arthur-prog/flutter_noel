import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/user/login/login_screen.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:flutter_noel/src/features/controllers/product/products_list/products_list_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({Key? key}) : super(key: key);

  final _productRepository = Get.put(ProductRepository());
  final _controller = Get.put(ProductsListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(() => const LoginScreen());
            },
            icon: const Icon(
              Icons.login,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text('Liste produit', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black)),
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
                stream: _productRepository.getProductsSnapshots(),
                builder: (BuildContext context, AsyncSnapshot productsSnapshot) {
                  List<Widget> children = [];
                  if (productsSnapshot.hasData) {
                    if (productsSnapshot.data!.docs.isEmpty) {
                        return const Text("no product");
                    } else {
                      productsSnapshot.data!.docs.forEach((doc) {
                        Map<String, dynamic> productJson = doc.data();
                        Product product = Product.fromMap(productJson);
                        children.add(
                            GestureDetector(
                              onTap: () {_controller.toProductDetails(product);},
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
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
                                                        fit: BoxFit.cover,
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
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                                              child: Text(
                                                product.name,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                                              child: Text(
                                                  product.price.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
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
                        child: Row(
                          children: [
                            SizedBox(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Filtres', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
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
