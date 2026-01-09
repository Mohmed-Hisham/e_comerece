import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:e_comerece/viwe/screen/Address/botton_sheet_location.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/checkout/review_fee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: CheckOutControllerImpl(),
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(height: 90.h),

                      Container(
                        margin: EdgeInsets.all(10.r),
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Appcolor.black, width: 2),
                          color: Appcolor.primrycolor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.discount != 0)
                                    Text(
                                      "${controller.total! + controller.discount}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black,
                                        decorationThickness: 2.0,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                      ),
                                    ),
                                  if (controller.discount != 0)
                                    Text(
                                      "Using Coupon (${controller.couponCode})",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Total: ',
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolor.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '\$${controller.total!.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.black,
                                            fontFamily: "asian",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: SizedBox(
                                height: 192.h,
                                child: PageView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: controller.pageController,

                                  itemBuilder: (context, index) {
                                    final itemCount =
                                        controller.cartItems.length;
                                    final realIndex = index % itemCount;

                                    final imageList = controller.cartItems
                                        .map((item) => item.productImage)
                                        .toList();
                                    final title = controller.cartItems
                                        .map((item) => item.productTitle)
                                        .toList();
                                    final platform = controller.cartItems
                                        .map((item) => item.cartPlatform)
                                        .toList();

                                    Widget mediaWidget;

                                    final imageIndex = realIndex;
                                    mediaWidget = GestureDetector(
                                      onTap: () => openFullImage(
                                        context,
                                        imageList[imageIndex].toString(),
                                      ),
                                      child: CachedNetworkImage(
                                        height: 100.h,
                                        imageUrl:
                                            secureUrl(imageList[imageIndex]) ??
                                            "",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Loadingimage(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );

                                    return Column(
                                      children: [
                                        Text(
                                          platform[realIndex].toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.black,
                                          ),
                                        ),
                                        AnimatedBuilder(
                                          animation: controller.pageController,
                                          builder: (context, child) {
                                            double value = 1.0;
                                            if (controller
                                                .pageController
                                                .position
                                                .haveDimensions) {
                                              value =
                                                  (controller
                                                      .pageController
                                                      .page! -
                                                  index);
                                              value = (1 - (value.abs() * 0.3))
                                                  .clamp(0.8, 1.0);
                                            }
                                            return Center(
                                              child: Transform.scale(
                                                scale: value,
                                                child: Container(
                                                  height: 100,
                                                  margin: const EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    child: child,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: mediaWidget,
                                        ),
                                        Text(
                                          title[realIndex].toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.black,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<CheckOutControllerImpl>(
                        id: 'location',
                        builder: (cont) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Stack(
                              children: [
                                BottonSheetLocation(
                                  physics: cont.isShowMore
                                      ? const BouncingScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  maxHeight: cont.isShowMore ? 320 : 250,
                                  showButtonBack: false,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.r),
                                  ),
                                ),
                                Positioned(
                                  right: 170.w,
                                  bottom: -15.h,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Appcolor.soecendcolor.withValues(
                                        alpha: 0.5,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.r),
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        cont.showMore();
                                      },
                                      icon: FaIcon(
                                        cont.isShowMore
                                            ? FontAwesomeIcons.arrowUp
                                            : FontAwesomeIcons.arrowDown,
                                        color: Appcolor.primrycolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Review Fee Card
                      const ReviewFeeCard(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Text(
                                    "Choose Payment Method",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolor.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.error_outline,
                                    color: Appcolor.primrycolor,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.arrowRight,
                                color: Appcolor.primrycolor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.r),
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Appcolor.threecolor),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(child: Text("Payment Info is here")),
                      ),
                      SizedBox(height: 20.h),
                      Custombuttonauth(
                        inputtext: "Place Order",
                        onPressed: () {
                          controller.checkOut();
                        },
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ],
              ),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {"platform": 'CheckOut'},
                  );
                },
              ),
              PositionedAppBar(title: "Checkout", onPressed: Get.back),
            ],
          );
        },
      ),
    );
  }
}
