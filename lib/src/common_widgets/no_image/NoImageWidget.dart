import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/images.dart';
import 'package:flutter_noel/src/utils/utils.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getImageUrl(noImageUrl),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: height,
              width: width,
              child: Image.network(snapshot.data!),
            );
          }
          return SizedBox(
            height: height,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
