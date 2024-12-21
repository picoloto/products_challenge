import 'package:flutter/material.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/image_network_widget.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';

class ProductTileWidget extends StatelessWidget {
  final Product product;
  final Widget? favoriteWidget;

  const ProductTileWidget({
    super.key,
    required this.product,
    this.favoriteWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        spacing: 18,
        children: [
          ImageNetworkWidget(
            imageUrl: product.image,
            width: 126,
            height: 126,
          ),
          Expanded(
            child: Column(
              spacing: 9,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.neutral,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RateWidget(
                        rate: product.rating.rate,
                        reviewCount: product.rating.count,
                      ),
                    ),
                    Visibility(
                      visible: favoriteWidget != null,
                      child: favoriteWidget ?? SizedBox.shrink(),
                    ),
                  ],
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.attention,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
