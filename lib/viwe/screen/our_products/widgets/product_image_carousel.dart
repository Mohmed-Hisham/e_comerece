import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageCarousel extends StatefulWidget {
  final LocalProductModel product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        // color: Appcolor.white,
        borderRadius: BorderRadius.circular(20.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.05),
        //     blurRadius: 15,
        //     offset: const Offset(0, 5),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          // Main Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: SizedBox(height: 300.h, child: _buildImageContent()),
          ),
          // Image Indicators
          if (widget.product.images != null &&
              widget.product.images!.length > 1)
            _buildIndicators(),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    if (widget.product.images != null && widget.product.images!.isNotEmpty) {
      return CarouselSlider.builder(
        itemCount: widget.product.images!.length,
        itemBuilder: (context, index, _) {
          return Hero(
            tag: widget.product.id ?? "",
            child: CustomCachedImage(
              imageUrl: widget.product.images![index],
              fit: BoxFit.contain,
            ),
          );
        },
        options: CarouselOptions(
          height: 300.h,
          viewportFraction: 1,
          enableInfiniteScroll: widget.product.images!.length > 1,
          onPageChanged: (index, _) {
            setState(() {
              currentImageIndex = index;
            });
          },
        ),
      );
    }
    return Hero(
      tag: widget.product.id ?? "",
      child: CustomCachedImage(
        imageUrl: widget.product.mainImage ?? "",
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildIndicators() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.product.images!.length,
          (index) => Container(
            width: currentImageIndex == index ? 20.w : 8.w,
            height: 8.h,
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: currentImageIndex == index
                  ? Appcolor.primrycolor
                  : Appcolor.gray.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      ),
    );
  }
}
