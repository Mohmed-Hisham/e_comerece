import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: CachedNetworkImage(
        imageUrl: safeImageUrl(imageUrl),
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => const Loadingimage(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
