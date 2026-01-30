import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  final String whatsappNumber = "+967782009966";

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/${whatsappNumber.replaceAll('+', '')}",
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showCustomGetSnack(isGreen: false, text: StringsKeys.whatsappError.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          SafeArea(
            child: Column(
              children: [
                AppBarContent(
                  title: StringsKeys.contactUs.tr,
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 30.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringsKeys.contactUsHelpTitle.tr,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          StringsKeys.contactUsHelpBody.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Appcolor.gray,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        GestureDetector(
                          onTap: _launchWhatsApp,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 30.h,
                              horizontal: 20.w,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF25D366,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.white,
                                  size: 60.sp,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  StringsKeys.contactWhatsApp.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  whatsappNumber,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 18.sp,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
