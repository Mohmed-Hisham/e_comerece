import 'package:e_comerece/controller/aliexpriess/shearchname_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductFromCat extends StatelessWidget {
  const ProductFromCat({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShearchnameControllerImple());
    Get.put(FavoritesController());
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          GetBuilder<ShearchnameControllerImple>(
            builder: (controller) {
              return PositionedAppBar(
                title: controller.nameCat ?? 'Search',
                onPressed: Get.back,
              );
            },
          ),
          GetBuilder<ShearchnameControllerImple>(
            builder: (controller) {
              final int itemCount = controller.categorymodel.length;
              if (itemCount > 0 &&
                  controller.categoryId.toString().isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // نحسب موقع العنصر المحدد
                  final selectedIndex = controller.categorymodel.indexWhere(
                    (cat) => cat.id == controller.categoryId,
                  );
                  if (selectedIndex == 0 || selectedIndex == 1) {
                    return;
                  }

                  if (selectedIndex != -1) {
                    // نحسب البوزيشن اللي نسكرول ليه (كل عنصر عرضه 100)
                    final screenWidth = MediaQuery.of(context).size.width;
                    final offset =
                        (screenWidth / 2) - 50; // نص الشاشة - نص العنصر
                    final targetPosition = (selectedIndex * 100.0) - offset;

                    // نتأكد إن الـ controller مرتبط بالـ ListView
                    if (scrollController.hasClients) {
                      scrollController.animateTo(
                        targetPosition,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                });
              }

              return Column(
                children: [
                  SizedBox(height: 110.h),
                  SizedBox(
                    height: 110.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final bool useModel =
                            controller.categorymodel.isNotEmpty;

                        // اختر العنصر الحالي من اللستة الصحيحة
                        final dynamic current = useModel
                            ? controller.categorymodel[index]
                            : controller.categorymodelFromImage[index];

                        // احصل على الـ id و name بطريقة
                        final int currentId = useModel
                            ? (current.id ?? 0)
                            : int.tryParse(current.id.toString()) ?? 0;
                        final String currentName = current.name ?? 'Unknown';

                        // IconData من الخريطة أو أيقونة افتراضية
                        final IconData iconToShow =
                            categoryIcons[currentId] ??
                            FontAwesomeIcons.tableCellsLarge;

                        final bool isSelected =
                            controller.categoryId == currentId ||
                            controller.selectedIndex == index;

                        final Widget iconWidget =
                            (iconToShow.fontPackage != null &&
                                iconToShow.fontPackage ==
                                    'font_awesome_flutter')
                            ? FaIcon(
                                iconToShow,
                                size: 24,
                                color: Appcolor.black2,
                              )
                            : Icon(
                                iconToShow,
                                size: 24,
                                color: Appcolor.black2,
                              );

                        return InkWell(
                          onTap: () {
                            controller.changeCat(currentName, currentId, index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 120.w,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        color: Appcolor.white,
                                        border: Border.all(
                                          color: isSelected
                                              ? Appcolor.primrycolor
                                              : Appcolor.threecolor,
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(child: iconWidget),
                                    ),
                                    if (useModel &&
                                        (current.list != null &&
                                            current.list.isNotEmpty))
                                      Custmenubutton(
                                        onSelected: (p0) {
                                          final map =
                                              p0 as Map<String, dynamic>?;
                                          String name = map!["name"].toString();
                                          int id = int.parse(
                                            map["id"].toString(),
                                          );
                                          controller.changeCat(name, id, index);
                                        },
                                        itemBuilder: (context) => current.list
                                            .map<PopupMenuEntry>((sub) {
                                              return PopupMenuItem(
                                                value: {
                                                  "id": sub.id,
                                                  "name": sub.name,
                                                },
                                                child: Text(
                                                  sub.name ?? 'Unknown',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  width: 110.w,
                                  child: Text(
                                    currentName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Appcolor.black2,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(color: Appcolor.gray, thickness: 1.h),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: PaginationListener(
                      fetchAtEnd: true,
                      onLoadMore: () {
                        controller.loadMoreSearch();
                      },
                      child: Handlingdataviwe(
                        // shimmer: ShimmerGrideviwe(),
                        statusrequest: controller.statusrequest,
                        widget: RefreshIndicator(
                          color: Appcolor.primrycolor,
                          backgroundColor: Colors.transparent,
                          onRefresh: () => controller.fetchShearchname(
                            controller.nameCat!,
                            controller.categoryId!,
                            isLoadMore: false,
                          ),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            key: Key(controller.categoryId.toString()),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  mainAxisExtent: 420.h,
                                ),
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              final product = controller.items[index];
                              final currencyService =
                                  Get.find<CurrencyService>();

                              return InkWell(
                                onTap: () {
                                  controller.gotoditels(
                                    id: product.item?.itemId ?? 0,
                                    lang: enOrAr(),
                                    title: product.item?.title ?? "",
                                  );
                                },
                                child: Custgridviwe(
                                  image: CustomCachedImage(
                                    imageUrl: product.item?.image ?? "",
                                  ),
                                  disc: calculateDiscountPercent(
                                    product.item?.sku?.def?.price ?? 0,
                                    product.item?.sku?.def?.promotionPrice ?? 0,
                                  ),
                                  title: product.item?.title ?? "",
                                  price: currencyService.convertAndFormat(
                                    amount: extractPrice(
                                      product.item?.sku?.def?.promotionPrice ??
                                          "0",
                                    ),
                                    from: 'USD',
                                  ),
                                  icon: GetBuilder<FavoritesController>(
                                    builder: (isFavoriteController) {
                                      bool isFav =
                                          isFavoriteController
                                              .isFavorite[product.item!.itemId
                                              .toString()] ??
                                          false;

                                      return IconButton(
                                        onPressed: () {
                                          isFavoriteController.toggleFavorite(
                                            product.item?.itemId.toString() ??
                                                "",
                                            product.item?.title ?? "",
                                            product.item?.itemUrl ?? "",
                                            currencyService
                                                .convert(
                                                  amount: extractPrice(
                                                    product
                                                            .item
                                                            ?.sku
                                                            ?.def
                                                            ?.promotionPrice ??
                                                        "0",
                                                  ),
                                                  from: 'USD',
                                                  to: 'USD',
                                                )
                                                .toString(),
                                            "Aliexpress",
                                          );
                                        },
                                        icon: FaIcon(
                                          isFav
                                              ? FontAwesomeIcons.solidHeart
                                              : FontAwesomeIcons.heart,
                                          color: isFav
                                              ? Appcolor.reed
                                              : Appcolor.reed,
                                        ),
                                      );
                                    },
                                  ),
                                  discprice: currencyService.convertAndFormat(
                                    amount: extractPrice(
                                      product.item?.sku?.def?.price ?? "0",
                                    ),
                                    from: 'USD',
                                  ),
                                  countsall:
                                      "${product.item?.sales} ${StringsKeys.sales.tr}",
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLoading && controller.hasMore)
                    ShimmerBar(height: 8, animationDuration: 1),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
