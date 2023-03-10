import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/utils/utils.dart';

class ProductLineWidget extends StatelessWidget {
  const ProductLineWidget({
    super.key,
    required this.cartProduct,
    this.onIncrementQuantity,
    this.onDecrementQuantity,
  });
  final CartProduct cartProduct;
  final VoidCallback? onIncrementQuantity;
  final VoidCallback? onDecrementQuantity;

  @override
  Widget build(BuildContext context) {
    final Product? product = cartProduct.product;
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
              future: cartProduct.variant == null ? getImageUrl(product!.urlPicture) : getImageUrl(cartProduct.variant!.urlPicture!),
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
                cartProduct.variant != null ?
                cartProduct.variant!.size != null ?
                Text(
                  cartProduct.variant!.size!,
                  style: Theme.of(context).textTheme.bodyText1,
                ) : const SizedBox() : const SizedBox(),
                cartProduct.variant != null ?
                cartProduct.variant!.color != null ?
                Text(
                  cartProduct.variant!.color!,
                  style: Theme.of(context).textTheme.bodyText1,
                ) : const SizedBox() : const SizedBox(),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              cartProduct.variant == null ? '${product.price}€' : '${cartProduct.variant!.price}€',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: onDecrementQuantity,
              icon: const Icon(
                Icons.remove,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              cartProduct.quantity.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: onDecrementQuantity,
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}