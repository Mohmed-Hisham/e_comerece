import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/servises/safe_image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double? height;
  final double? width;
  final BoxFit fit;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.radius = 12,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? MediaQuery.of(context).size.width;

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius.r),
        child: CachedNetworkImage(
          imageUrl: safeImageUrl(imageUrl),
          width: width ?? double.infinity,
          height: height,
          fit: fit,
          placeholder: (context, url) {
            return Container(
              width: width ?? double.infinity,
              height: height ?? 200.h,
              color: Colors.grey.shade200,
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              width: width ?? double.infinity,
              height: height ?? 200.h,
              color: Colors.grey.shade200,
              child: const Icon(Icons.error),
            );
          },
          imageBuilder: (context, imageProvider) {
            final int decodeWidth =
                (w * MediaQuery.of(context).devicePixelRatio).toInt();
            final ImageProvider resized = ResizeImage(
              imageProvider,
              width: decodeWidth,
            );

            return Image(
              image: resized,
              width: width ?? double.infinity,
              height: height,
              fit: fit,
            );
          },
        ),
      ),
    );
  }
}
