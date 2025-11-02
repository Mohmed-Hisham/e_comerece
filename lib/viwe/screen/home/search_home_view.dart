import 'dart:developer';

import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
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
        log('build');
        return Handlingdataviwe(
          statusrequest: controller.statusRequestHome,
          widget: CustomScrollView(
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
                      children: PlatformSource.values.map((p) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
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
                              p == PlatformSource.all ? 'All' : p.name,
                            ),
                            selected: controller.selected == p,
                            onSelected: (val) {
                              controller.setPlatform(p);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              SliverSpacer(15),
              if (controller.selected == PlatformSource.all ||
                  controller.selected == PlatformSource.aliexpress) ...[
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      CustLabelContainer(text: 'product from aliexpress'),
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
                        child: ShimmerBar(height: 8, animationDuration: 1),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),

                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 10,
                    children: [
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAliexpress();
                        },
                        title: 'loadMore aliexpress',
                      ),
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAliexpress(showless: true);
                        },
                        title: 'showLess aliexpress',
                      ),
                    ],
                  ),
                ),
                SliverSpacer(25),
              ],

              if (controller.selected == PlatformSource.all ||
                  controller.selected == PlatformSource.alibaba) ...[
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      CustLabelContainer(text: 'product from alibaba'),
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
                        child: ShimmerBar(height: 8, animationDuration: 1),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 10,
                    children: [
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAlibaba();
                        },
                        title: 'loadMore alibaba',
                      ),
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAlibaba(showless: true);
                        },
                        title: 'showLess alibaba',
                      ),
                    ],
                  ),
                ),
                SliverSpacer(25),
              ],

              if (controller.selected == PlatformSource.all ||
                  controller.selected == PlatformSource.amazon) ...[
                SliverToBoxAdapter(
                  child: Row(
                    children: [CustLabelContainer(text: 'product from amazon')],
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
                        child: ShimmerBar(height: 8, animationDuration: 1),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 10,
                    children: [
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAmazon();
                        },
                        title: 'loadMore amazon',
                      ),
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthAmazon(showless: true);
                        },
                        title: 'showLess amazon',
                      ),
                    ],
                  ),
                ),
                SliverSpacer(25),
              ],
              if (controller.selected == PlatformSource.all ||
                  controller.selected == PlatformSource.shein) ...[
                SliverToBoxAdapter(
                  child: Row(
                    children: [CustLabelContainer(text: 'product from shein')],
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
                        child: ShimmerBar(height: 8, animationDuration: 1),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 10,
                    children: [
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthShein();
                        },
                        title: 'loadMore shein',
                      ),
                      CustButtonBotton(
                        onTap: () {
                          controller.chngelengthShein(showless: true);
                        },
                        title: 'showLess shein',
                      ),
                    ],
                  ),
                ),
                SliverSpacer(25),
              ],
            ],
          ),
        );
      },
    );
  }
}
