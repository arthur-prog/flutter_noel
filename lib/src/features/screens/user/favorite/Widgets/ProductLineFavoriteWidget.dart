import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/utils/utils.dart';

class ProductLineFavoriteWidget extends StatelessWidget {
  const ProductLineFavoriteWidget({
    super.key,
    required this.favoriteProduct,
    this.removeProduct,
  });
  final FavoriteProduct favoriteProduct;
  final VoidCallback? removeProduct;

  @override
  Widget build(BuildContext context) {
    final Product? product = favoriteProduct.product;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 2,
            child: FutureBuilder(
              future: favoriteProduct.variant == null ? getImageUrl(product!.urlPicture) : getImageUrl(favoriteProduct.variant!.urlPicture!),
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      return Image.network(
                        snapshot.data,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const NoImageWidget(height: 100, width: 100);
                    }
                  } else {
                    return const SizedBox(height: 100, width: 100, child: CircularProgressIndicator());
                  }
                }
            ),
          ),

          Flexible(
            flex: 3,
            child: Column(
              children: [
                Text(
                  product!.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                favoriteProduct.variant != null ?
                favoriteProduct.variant!.size != null ?
                Text(
                  favoriteProduct.variant!.size!,
                  style: Theme.of(context).textTheme.bodyText1,
                ) : const SizedBox() : const SizedBox(),
                favoriteProduct.variant != null ?
                favoriteProduct.variant!.color != null ?
                Text(
                  favoriteProduct.variant!.color!,
                  style: Theme.of(context).textTheme.bodyText1,
                ) : const SizedBox() : const SizedBox(),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              favoriteProduct.variant == null ? '${product.price}€' : '${favoriteProduct.variant!.price}€',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Flexible(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.delete,color: Colors.red.withOpacity(0.9),),
              onPressed: removeProduct,
            )
          ),
        ],
      ),
    );
  }
}