import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:flutter_noel/src/features/controllers/product/product_details/product_details_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//add dev
class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;
  final _controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {_controller.back();},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
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
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${product.price}€',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          product.description,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Coloris disponibles',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        /*SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: smProducts.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: AppColors.kSmProductBgColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  height: 70,
                                  image: AssetImage(smProducts[index].image),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white70),
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Ajouter au panier',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))
                ),
              )
              ),
            //),
          ],
        ),
      ),
    );
  }
}
