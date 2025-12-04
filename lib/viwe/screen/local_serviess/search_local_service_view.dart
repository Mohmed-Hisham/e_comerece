import 'package:e_comerece/controller/local_service/local_service_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchLocalServiceView extends GetView<LocalServiceController> {
  const SearchLocalServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: false,
      statusrequest: controller.searchstatusrequest,
      widget: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 330.h,
        ),
        itemCount: controller.searchservices.length,
        itemBuilder: (context, index) {
          final service = controller.searchservices[index];
          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutesname.localServiceDetails,
                arguments: {'service': service},
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: CustomCachedImage(imageUrl: service.serviceImage!),
                disc: service.serviceName!,
                title: service.serviceName!,
                price: service.servicePrice.toString(),
                icon: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.heart,
                    color: Appcolor.reed,
                  ),
                ),
                discprice: service.servicePrice.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
