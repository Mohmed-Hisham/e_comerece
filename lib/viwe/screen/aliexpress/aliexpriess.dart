import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/controller/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/aliexpress/categories_list.dart';
import 'package:e_comerece/viwe/screen/aliexpress/hot_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(title: Text("Aliexpress")),
      body: GetBuilder<HomePageControllerImpl>(
        builder: (controller) {
          return Handlingdataviwe(
            statusrequest: controller.statusrequest,
            widget: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!controller.isLoading &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent * 0.8) {
                  controller.loadMore();
                }
                return true;
              },
              child: ListView(
                children: [
                  const Text(
                    '   Categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CategoriesList(),
                  const Divider(height: 32),
                  const Text(
                    '  Hot Deals',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  HotProductsGrid(),
                  if (controller.hasMore && controller.pageIndex > 0)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
