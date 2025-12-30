import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:flutter/material.dart';

class CartItemImage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onDelete;

  const CartItemImage({
    super.key,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: secureUrl(imageUrl) ?? '',
            width: 75,
            height: 75,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Loadingimage(),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
        Positioned(
          height: 30,
          width: 30,
          top: -5,
          left: -5,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.somgray,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              alignment: Alignment.center,
              iconSize: 15,
              icon: const Icon(
                Icons.delete_outline,
                color: Appcolor.primrycolor,
              ),
              onPressed: onDelete,
            ),
          ),
        ),
      ],
    );
  }
}
