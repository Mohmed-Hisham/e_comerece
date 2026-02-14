import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SizedBox(
      width: 85.w,
      height: 85.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: secureUrl(imageUrl) ?? '',
                width: 85.w,
                height: 85.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Loadingimage(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.broken_image, size: 24.sp)),
              ),
            ),
          ),
          Positioned(
            top: -6,
            left: -6,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.shade200, width: 1),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.red,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
