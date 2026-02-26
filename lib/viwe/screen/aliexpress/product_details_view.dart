import 'dart:convert';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/extract_image_urls.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/aliexpress/poduct_more_ditels.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/aliexpress/add_button_to_cart.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custattribute_selection.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custbuildpricedisplay.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custmedia_carousel.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custpackage_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custstock_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/productdescriptionhtml.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    String? productId = Get.arguments['product_id']?.toString();
    Get.put(ProductDetailsControllerImple(), tag: productId);

    return Scaffold(
      body: GetBuilder<ProductDetailsControllerImple>(
        tag: productId,
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),

              Container(
                margin: EdgeInsets.only(bottom: 50.h),
                padding: EdgeInsets.only(top: 100.h),
                child: Handlingdataviwe(
                  isproductdetails: true,
                  statusrequest: controller.statusrequest,
                  widget: PaginationListener(
                    fetchAtEnd: true,
                    isLoading: controller.isLoading,
                    onLoadMore: () {
                      if (controller.loadSearchOne == 0) {
                        controller.searshText();
                        controller.loadSearchOne = 1;
                      } else {
                        controller.loadMoreSearch(
                          detectLangFromQuery(controller.title!),
                        );
                      }
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(context, controller),
                        ),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              CustLabelContainer(
                                text: StringsKeys.relatedProducts.tr,
                              ),
                            ],
                          ),
                        ),

                        PoductMoreDitels(controller: controller),
                        if (controller.isLoading &&
                            controller.hasMoresearch &&
                            controller.pageIndexSearch > 0)
                          SliverToBoxAdapter(
                            child: ShimmerBar(
                              height: 9.h,
                              animationDuration: 1,
                            ),
                          ),
                        SliverSpacer(40.h),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedAppBar(
                title: StringsKeys.productDetailsTitle.tr,
                onPressed: Get.back,
              ),
              // CustbuttonAddCart(
              //   addcontroller: addcontroller,
              //   tag: controller.productId.toString(),
              // ),
              AddButtonToCart(tag: controller.productId.toString()),
              PositionedSupport(
                onPressed: () {
                  Get.toNamed(
                    AppRoutesname.messagesScreen,
                    arguments: {
                      "platform": 'alibaba',
                      "link_Product":
                          controller.itemDetailsModel?.result?.item?.itemUrl,
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final html =
        controller.itemDetailsModel?.result?.item?.description?.html ?? '';
    final images = extractImageUrls(html);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(""),
        CustmediaCarousel(tag: controller.productId.toString()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 8),
              ImagesCarousel(
                images: images,
                tag: controller.productId.toString(),
              ),
              const SizedBox(height: 8),
              _buildSellerInfo(context, controller),
              const SizedBox(height: 16),
              Custbuildpricedisplay(tag: controller.productId.toString()),
              const SizedBox(height: 16),
              CustattributeSelection(
                controller: controller,
                tag: controller.productId.toString(),
              ),
              const SizedBox(height: 16),
              Custpackageinfo(controller: controller),
              const SizedBox(height: 16),
              CuststockInfo(tag: controller.productId.toString()),
              const SizedBox(height: 16),
              _buildReviews(context, controller),
              const SizedBox(height: 16),
              _buildSpecifications(context, controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    final subject = controller.subject;
    if (subject == null) return const SizedBox.shrink();
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.productId.toString()] ?? false;
        return Row(
          children: [
            Expanded(
              child: Text(
                subject,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (isInCart)
              const Icon(Icons.shopping_cart, color: Appcolor.primrycolor),
          ],
        );
      },
    );
  }

  Widget _buildSellerInfo(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    return GetBuilder<ProductDetailsControllerImple>(
      tag: controller.productId.toString(),
      builder: (controller) {
        final sellerName = controller.sellerName;
        if (sellerName == null) return const SizedBox.shrink();
        return Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                sellerName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReviews(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    return GetBuilder<ProductDetailsControllerImple>(
      tag: controller.productId.toString(),
      builder: (controller) {
        final count = controller.reviewsCount;
        final avg = controller.averageStar;
        if (count == null && avg == null) {
          return const SizedBox.shrink();
        }
        return Row(
          children: [
            if (avg != null)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    avg,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Appcolor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            const SizedBox(width: 12),
            if (count != null)
              Text(
                '( $count ${StringsKeys.reviews.tr} )',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSpecifications(
    BuildContext context,
    ProductDetailsControllerImple controller,
  ) {
    return GetBuilder<ProductDetailsControllerImple>(
      tag: controller.productId.toString(),
      builder: (controller) {
        final specs = controller.specifications;
        if (specs.isEmpty) return const SizedBox.shrink();
        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Appcolor.primrycolor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    StringsKeys.specifications.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              // Filter out properties that contain raw JSON data
              ...specs
                  .where((s) => !_isJsonValue(s.value))
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) {
                    final index = entry.key;
                    final s = entry.value;
                    final isEven = index % 2 == 0;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isEven
                            ? Appcolor.primrycolor.withValues(alpha: 0.05)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              s.name ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Appcolor.gray,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 3,
                            child: Text(
                              s.value ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Appcolor.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              // Render size_info as a proper size chart table
              ..._buildSizeCharts(context, specs),
            ],
          ),
        );
      },
    );
  }

  /// Check if a property value is raw JSON (not human-readable)
  bool _isJsonValue(String? value) {
    if (value == null || value.isEmpty) return false;
    final trimmed = value.trim();
    if (trimmed.startsWith('{') ||
        trimmed.startsWith('[') ||
        trimmed.contains('sizeInfoList') ||
        trimmed.contains('"vid":') ||
        trimmed.contains('"cm"') ||
        trimmed.contains('"inch"')) {
      return true;
    }
    return false;
  }

  /// Build size chart widgets from specs that contain size_info JSON
  List<Widget> _buildSizeCharts(BuildContext context, List<SpecItem> specs) {
    final sizeSpecs = specs.where((s) => _isJsonValue(s.value)).toList();
    if (sizeSpecs.isEmpty) return [];

    final List<Widget> widgets = [];
    for (final spec in sizeSpecs) {
      final parsed = _parseSizeInfo(spec.value!);
      if (parsed == null || parsed.isEmpty) continue;

      widgets.add(SizedBox(height: 16.h));
      widgets.add(
        Row(
          children: [
            Icon(Icons.straighten, color: Appcolor.primrycolor, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              StringsKeys.sizeChart.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
      widgets.add(SizedBox(height: 10.h));
      widgets.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildSizeTable(context, parsed),
          ),
        ),
      );
    }
    return widgets;
  }

  /// Parse the raw size_info JSON string into a list of maps
  List<Map<String, String>>? _parseSizeInfo(String raw) {
    try {
      String jsonStr = raw;

      // Try to find sizeInfoList array
      final listMatch = RegExp(
        r'"sizeInfoList"\s*:\s*(\[.*\])',
        dotAll: true,
      ).firstMatch(raw);
      if (listMatch != null) {
        jsonStr = listMatch.group(1)!;
      } else if (!raw.trimLeft().startsWith('[')) {
        // Try wrapping the whole thing as JSON
        // Maybe it's something like: مقاس واحد,{...}
        final braceStart = raw.indexOf('[');
        if (braceStart != -1) {
          jsonStr = raw.substring(braceStart);
          // Find matching close bracket
          final braceEnd = jsonStr.lastIndexOf(']');
          if (braceEnd != -1) {
            jsonStr = jsonStr.substring(0, braceEnd + 1);
          }
        } else {
          return null;
        }
      }

      final decoded = jsonDecode(jsonStr);
      if (decoded is! List) return null;

      final List<Map<String, String>> result = [];
      for (final item in decoded) {
        if (item is! Map) continue;
        final Map<String, String> row = {};

        // Extract size name
        final sizeName = item['size'] ?? item['مقاس'] ?? '';
        if (sizeName.toString().isNotEmpty) {
          row['Size'] = sizeName.toString();
        }

        // Extract length info
        if (item['length'] is Map) {
          final length = item['length'] as Map;
          final cm = length['cm']?.toString() ?? '';
          final inch = length['inch']?.toString() ?? '';
          if (cm.isNotEmpty && cm != '') row['Length (cm)'] = cm;
          if (inch.isNotEmpty && inch != '') row['Length (inch)'] = inch;
        }

        // Check for other common measurement keys
        for (final key in [
          'bust',
          'waist',
          'hip',
          'shoulder',
          'sleeve',
          'chest',
          'height',
          'width',
        ]) {
          if (item[key] is Map) {
            final measure = item[key] as Map;
            final cm = measure['cm']?.toString() ?? '';
            if (cm.isNotEmpty && cm != '') {
              row['${key[0].toUpperCase()}${key.substring(1)} (cm)'] = cm;
            }
          }
        }

        if (row.isNotEmpty) result.add(row);
      }
      return result.isEmpty ? null : result;
    } catch (_) {
      return null;
    }
  }

  /// Build a DataTable from parsed size info
  Widget _buildSizeTable(BuildContext context, List<Map<String, String>> data) {
    // Collect all unique column keys
    final columns = <String>{};
    for (final row in data) {
      columns.addAll(row.keys);
    }
    final colList = columns.toList();

    // Ensure "Size" is first
    if (colList.contains('Size')) {
      colList.remove('Size');
      colList.insert(0, 'Size');
    }

    return DataTable(
      headingRowColor: WidgetStateProperty.all(
        Appcolor.primrycolor.withValues(alpha: 0.15),
      ),
      dataRowColor: WidgetStateProperty.all(Colors.white),
      horizontalMargin: 12.w,
      columnSpacing: 16.w,
      headingRowHeight: 40.h,
      dataRowMinHeight: 36.h,
      dataRowMaxHeight: 48.h,
      border: TableBorder.all(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.r),
        width: 1,
      ),
      columns: colList
          .map(
            (col) => DataColumn(
              label: Text(
                col,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Appcolor.black,
                ),
              ),
            ),
          )
          .toList(),
      rows: data
          .map(
            (row) => DataRow(
              cells: colList
                  .map(
                    (col) => DataCell(
                      Text(
                        row[col] ?? '-',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Appcolor.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
