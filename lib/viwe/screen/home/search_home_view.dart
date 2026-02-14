import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/servises/platform_ext.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/home/plateform_search/search_alibaba.dart';
import 'package:e_comerece/viwe/screen/home/plateform_search/search_aliexpriess.dart';
import 'package:e_comerece/viwe/screen/home/plateform_search/search_amazon.dart';
import 'package:e_comerece/viwe/screen/home/plateform_search/search_shein.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHomeView extends StatelessWidget {
  const SearchHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      builder: (controller) {
        return Handlingdataviwe(
          statusrequest: controller.statusRequestHome,
          widget: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverAppBar(
                      pinned: true,
                      floating: false,
                      backgroundColor: Appcolor.white2,
                      bottom: PreferredSize(
                        preferredSize: Size.zero,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: PlatformSource.values
                                .where((p) {
                                  if (p == PlatformSource.aliexpress) {
                                    return AppConfigService.to.showAliExpress;
                                  }
                                  if (p == PlatformSource.alibaba) {
                                    return AppConfigService.to.showAlibaba;
                                  }
                                  if (p == PlatformSource.amazon) {
                                    return AppConfigService.to.showAmazon;
                                  }
                                  if (p == PlatformSource.shein) {
                                    return AppConfigService.to.showShein;
                                  }
                                  return true;
                                })
                                .map((p) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    child: ChoiceChip(
                                      checkmarkColor: controller.selected == p
                                          ? Appcolor.white
                                          : Appcolor.black,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller.selected == p
                                            ? Appcolor.white
                                            : Appcolor.black,
                                      ),
                                      selectedColor: Appcolor.primrycolor,
                                      label: Text(
                                        p == PlatformSource.all
                                            ? StringsKeys.all.tr
                                            : p.name,
                                      ),
                                      selected: controller.selected == p,
                                      onSelected: (val) {
                                        controller.setPlatform(p);
                                      },
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                    ),

                    SliverSpacer(15),
                    if ((controller.selected == PlatformSource.all ||
                            controller.selected == PlatformSource.aliexpress) &&
                        AppConfigService.to.showAliExpress) ...[
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            CustLabelContainer(
                              text: StringsKeys.productFromAliexpress.tr,
                            ),
                          ],
                        ),
                      ),

                      GetBuilder<HomescreenControllerImple>(
                        id: 'aliexpress',
                        builder: (controllerAliexpress) {
                          return SliverPadding(
                            padding: const EdgeInsets.all(10),
                            sliver: SearchAliexpriess(controller: controller),
                          );
                        },
                      ),
                      GetBuilder<HomescreenControllerImple>(
                        id: 'aliexpress',
                        builder: (controllerAliexpress) {
                          if (controllerAliexpress.isLoadingAliExpress &&
                              controller.hasMoreAliexpress) {
                            return const SliverToBoxAdapter(
                              child: ShimmerBar(
                                height: 8,
                                animationDuration: 1,
                              ),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAliexpress();
                                  },
                                  title: StringsKeys.loadMoreAliexpress.tr,
                                ),
                              ),
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAliexpress(
                                      showless: true,
                                    );
                                  },
                                  title: StringsKeys.showLessAliexpress.tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverSpacer(25),
                    ],

                    if ((controller.selected == PlatformSource.all ||
                            controller.selected == PlatformSource.alibaba) &&
                        AppConfigService.to.showAlibaba) ...[
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            CustLabelContainer(
                              text: StringsKeys.productFromAlibaba.tr,
                            ),
                          ],
                        ),
                      ),

                      GetBuilder<HomescreenControllerImple>(
                        id: 'alibaba',
                        builder: (controllerAliexpress) {
                          return SliverPadding(
                            padding: const EdgeInsets.all(10),
                            sliver: SearchAlibaba(controller: controller),
                          );
                        },
                      ),
                      GetBuilder<HomescreenControllerImple>(
                        id: 'alibaba',
                        builder: (controllerAliexpress) {
                          if (controllerAliexpress.isLoadingSearchAlibaba &&
                              controller.hasMoresearchAlibaba) {
                            return const SliverToBoxAdapter(
                              child: ShimmerBar(
                                height: 8,
                                animationDuration: 1,
                              ),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAlibaba();
                                  },
                                  title: StringsKeys.loadMoreAlibaba.tr,
                                ),
                              ),
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAlibaba(
                                      showless: true,
                                    );
                                  },
                                  title: StringsKeys.showLessAlibaba.tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverSpacer(25),
                    ],

                    if ((controller.selected == PlatformSource.all ||
                            controller.selected == PlatformSource.amazon) &&
                        AppConfigService.to.showAmazon) ...[
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            CustLabelContainer(
                              text: StringsKeys.productFromAmazon.tr,
                            ),
                          ],
                        ),
                      ),

                      GetBuilder<HomescreenControllerImple>(
                        id: 'amazon',
                        builder: (controllerAliexpress) {
                          return SliverPadding(
                            padding: const EdgeInsets.all(10),
                            sliver: SearchAmazon(controller: controller),
                          );
                        },
                      ),
                      GetBuilder<HomescreenControllerImple>(
                        id: 'amazon',
                        builder: (controllerAliexpress) {
                          if (controllerAliexpress.isLoadingAmazon &&
                              controller.hasMoreAmazon) {
                            return const SliverToBoxAdapter(
                              child: ShimmerBar(
                                height: 8,
                                animationDuration: 1,
                              ),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAmazon();
                                  },
                                  title: StringsKeys.loadMoreAmazon.tr,
                                ),
                              ),
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthAmazon(
                                      showless: true,
                                    );
                                  },
                                  title: StringsKeys.showLessAmazon.tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverSpacer(25),
                    ],
                    if ((controller.selected == PlatformSource.all ||
                            controller.selected == PlatformSource.shein) &&
                        AppConfigService.to.showShein) ...[
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            CustLabelContainer(
                              text: StringsKeys.productFromShein.tr,
                            ),
                          ],
                        ),
                      ),

                      GetBuilder<HomescreenControllerImple>(
                        id: 'shein',
                        builder: (controllerAliexpress) {
                          return SliverPadding(
                            padding: const EdgeInsets.all(10),
                            sliver: SearchShein(controller: controller),
                          );
                        },
                      ),
                      GetBuilder<HomescreenControllerImple>(
                        id: 'shein',
                        builder: (controllerAliexpress) {
                          if (controllerAliexpress.isLoadingSearchShein &&
                              controller.hasMoresearchShein) {
                            return const SliverToBoxAdapter(
                              child: ShimmerBar(
                                height: 8,
                                animationDuration: 1,
                              ),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthShein();
                                  },
                                  title: StringsKeys.loadMoreShein.tr,
                                ),
                              ),
                              Expanded(
                                child: CustButtonBotton(
                                  onTap: () {
                                    controller.chngelengthShein(showless: true);
                                  },
                                  title: StringsKeys.showLessShein.tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverSpacer(25),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
