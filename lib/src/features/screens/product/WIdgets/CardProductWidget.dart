import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/utils/utils.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({
    super.key,
    required this.product,
    required this.margin,
  });

  final Product product;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(margin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: getImageUrl(product.urlPicture),
            builder: (BuildContext context,
                AsyncSnapshot imageSnapshot) {
              if (imageSnapshot.connectionState ==
                  ConnectionState.done) {
                if (imageSnapshot.hasData) {
                  return Image.network(
                    imageSnapshot.data,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const NoImageWidget(
                      height: 100, width: 100);
                }
              } else {
                return const SizedBox(height: 50, width: 50, child: CircularProgressIndicator());
              }
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1,
                ),
                Text(
                  "${product.price} €",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}