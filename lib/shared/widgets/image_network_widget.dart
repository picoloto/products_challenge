import 'package:flutter/material.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress != null) {
            return LoadingWidget();
          }
          return Center(child: child);
        },
      ),
    );
  }
}
