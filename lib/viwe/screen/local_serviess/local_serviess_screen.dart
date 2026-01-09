import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/controller/local_service/local_service_controller.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/local_serviess/search_local_service_view.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/custshearchappbar.dart';
import 'package:e_comerece/viwe/widget/local_service/local_service_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalServiessScreen extends StatelessWidget {
  const LocalServiessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocalServiceController());
    // Get.put(FavoritesController());

    return Scaffold(
      body: GetBuilder<LocalServiceController>(
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: StringsKeys.localServicesTitle.tr),

              Column(
                children: [
                  SizedBox(height: 95.h),
                  Custshearchappbar(
                    hintText: StringsKeys.searchServiceHint.tr,
                    mycontroller: controller.searchController,
                    showClose: controller.showClose,
                    onTapClose: () {
                      controller.onCloseSearch();
                    },
                    onChanged: (val) {
                      controller.checkSearch(val);
                      controller.whenstartSearch(val);
                    },
                    onTapSearch: () {
                      controller.onSearchItems();
                    },
                    isLocalService: true,
                    favoriteOnPressed: () {
                      Get.toNamed(AppRoutesname.viewLocalServiceOrders);
                    },
                  ),
                  SizedBox(height: 10.h),

                  Expanded(
                    child: controller.isSearch
                        ? SearchLocalServiceView()
                        : CustomScrollView(
                            controller: controller.scrollController,
                            slivers: [
                              LocalServiceData(),

                              if (controller.isLoading)
                                const SliverToBoxAdapter(
                                  child: ShimmerBar(
                                    height: 8,
                                    animationDuration: 1,
                                  ),
                                ),
                            ],
                          ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {"platform": 'localService'},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
