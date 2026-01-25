import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/servises/currency_service.dart';
import '../../../../controller/CheckOut/checkout_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/shared/widget_shared/fix_url.dart';
import '../../../../core/shared/widget_shared/loadingimage.dart';

class CheckoutSummaryCard extends GetView<CheckOutControllerImpl> {
  const CheckoutSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyService = Get.find<CurrencyService>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsKeys.orderInformation.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.cartItems.length,
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return Row(
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      "x${item.cartQuantity}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Appcolor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50.w,
                      height: 50.w,
                      imageUrl: secureUrl(item.productImage) ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Loadingimage(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 20),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Text(
                      item.productTitle ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Appcolor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    currencyService.convertAndFormat(
                      amount: item.productPrice ?? 0,
                      from: 'USD',
                    ),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
