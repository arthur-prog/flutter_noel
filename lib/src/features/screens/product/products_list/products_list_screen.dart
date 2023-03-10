import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/product/WIdgets/CardProductWidget.dart';
import 'package:flutter_noel/src/features/screens/product/products_list/Widgets/FliterWidget.dart';
import 'package:flutter_noel/src/features/screens/user/login/login_screen.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:flutter_noel/src/features/controllers/product/products_list/products_list_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({Key? key, required this.isConnected}) : super(key: key);

  final _productRepository = Get.put(ProductRepository());
  final _controller = Get.put(ProductsListController());
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
          leading: IconButton(
            onPressed: isConnected ? _controller.logout : _controller.login,
            icon: Icon(
              isConnected ? Icons.logout : Icons.login,
            ),
          ),
          title: Text(AppLocalizations.of(context)!.productsList,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                _controller.toProductSearched();
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Obx(
              () => StreamBuilder(
                stream: _productRepository
                    .getProductsSnapshotsByCategories(_controller.category.value),
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
                              onTap: () {
                                _controller.toProductDetails(product);
                              },
                              child: CardProductWidget(product: product, margin: 12),
                            ));
                      });
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.83,
                        child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1),
                            children: children),
                      ),
                    ],
                  );
                },
              ),
            )),
        floatingActionButton: FilterWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
