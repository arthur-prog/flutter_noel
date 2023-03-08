import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_noel/src/features/screens/product/product_details/product_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';



class ProductSearchedController extends GetxController {
  static ProductSearchedController get instance => Get.find();

  TextEditingController productController = TextEditingController();
  StreamController<String> productStream = StreamController<String>();

  void toProductDetails(Product product){
    Get.to(() => ProductDetailsScreen(product: product));
  }

  void back(){
    Get.back();
  }

  SizedBox buildProducts(
      ProductSearchedController controller,
      BuildContext context,
      List<Product> products
      ){
    List<Widget> children = [];

    products.forEach((product) {
      children.add(
          GestureDetector(
            onTap: () {controller.toProductDetails(product);},
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.2,
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1
          ),
          children: children
      ),
    );
  }
}