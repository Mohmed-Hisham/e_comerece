import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/viwe/screen/home/search_home_view.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late HomescreenControllerImple controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomescreenControllerImple>();
    // Focus على الـ TextField تلقائياً لما الصفحة تفتح
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // ✅ مسح البحث بعد frame عشان نتجنب الـ error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<HomescreenControllerImple>()) {
        controller.onCloseSearch();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          SafeArea(
            child: Column(
              children: [
                // Search App Bar
                _buildSearchBar(),
                // Search Results
                Expanded(
                  child: GetBuilder<HomescreenControllerImple>(
                    builder: (controller) {
                      if (!controller.isSearch) {
                        // Empty state - لما لسه مبدأش يبحث
                        return _buildEmptyState();
                      }
                      return const SearchHomeView();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            // Back Button
            IconButton(
              onPressed: () => Get.back(),
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(
                  langDirection() ? 1.0 : -1.0,
                  1.0,
                  1.0,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Appcolor.primrycolor,
                ),
              ),
            ),
            // Search Field
            Expanded(
              child: GetBuilder<HomescreenControllerImple>(
                id: 'initShow', // ✅ نفس الـ id المستخدم في controller
                builder: (controller) {
                  return TextFormField(
                    focusNode: _focusNode,
                    controller: controller.searchController,
                    validator: (value) {
                      return validateInput(val: value!, min: 3, max: 100);
                    },
                    onChanged: (val) {
                      controller.onChangeSearch(val);
                      controller.whenstartSearch(val);
                    },
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        controller.searshAll();
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Appcolor.somgray,
                      hintText: StringsKeys.searchHint.tr,
                      hintStyle: TextStyle(color: Appcolor.black),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Appcolor.primrycolor,
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.showClose)
                            IconButton(
                              onPressed: () {
                                controller.onCloseSearch();
                              },
                              icon: Icon(Icons.close, color: Appcolor.black2),
                            ),
                          IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.searshAll();
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80.sp,
            color: Appcolor.gray.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            StringsKeys.searchHint.tr,
            style: TextStyle(fontSize: 16.sp, color: Appcolor.gray),
          ),
          SizedBox(height: 8.h),
          Text(
            StringsKeys.searchForProducts.tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: Appcolor.gray.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
