import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/bluer_dilog.dart';
import 'package:e_comerece/viwe/screen/Address/botton_sheet_location.dart';
import 'package:e_comerece/viwe/screen/auth/logout_screen.dart';
import 'package:e_comerece/viwe/screen/settings/about_us_view.dart';
import 'package:e_comerece/viwe/screen/settings/contact_us_view.dart';
import 'package:e_comerece/viwe/screen/settings/language.dart';
import 'package:e_comerece/viwe/widget/settings/currency_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImple controller = Get.put(SettingsControllerImple());
    final TextStyle styleAll = TextStyle(
      color: Appcolor.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Get.width / 2.5,
                    color: Appcolor.primrycolor,
                  ),
                  Positioned(
                    top: Get.width / 3.2,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.asset(
                        AppImagesassets.avata,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          controller.goToUpdateProfile();
                        },
                        title: Text(
                          StringsKeys.updateProfile.tr,
                          style: styleAll,
                        ),
                        trailing: const Icon(
                          Icons.person_outline,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      // GetBuilder<SettingsControllerImple>(
                      //   id: 'notification',
                      //   builder: (controller) {
                      //     return ListTile(
                      //       title: Text(
                      //         StringsKeys.disableNotifications.tr,
                      //         style: styleAll,
                      //       ),
                      //       trailing: Switch(
                      //         trackColor: WidgetStatePropertyAll(
                      //           Appcolor.primrycolor,
                      //         ),
                      //         value: controller.isNotification,
                      //         onChanged: (val) {
                      //           controller.disableNotification();
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      ListTile(
                        onTap: () {
                          controller.goToHistryChats();
                        },
                        title: Text(
                          StringsKeys.historyChats.tr,
                          style: styleAll,
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.comments,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.bottomSheet(
                            BottonSheetLocation(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                          );
                        },
                        title: Text(StringsKeys.address.tr, style: styleAll),
                        trailing: Icon(
                          Icons.location_on_outlined,
                          color: Appcolor.primrycolor,
                        ),
                      ),

                      ListTile(
                        onTap: () {
                          Get.to(() => const AboutUsView());
                        },
                        title: Text(StringsKeys.aboutUs.tr, style: styleAll),
                        trailing: Icon(
                          Icons.help_outline,
                          color: Appcolor.primrycolor,
                        ),
                      ),

                      ListTile(
                        onTap: () {
                          Get.to(() => const ContactUsView());
                        },
                        title: Text(StringsKeys.contactUs.tr, style: styleAll),
                        trailing: Icon(
                          Icons.contact_phone_outlined,
                          color: Appcolor.primrycolor,
                        ),
                      ),

                      ListTile(
                        onTap: () {
                          blurDilog(MyLanguage(), context);
                        },
                        title: Text(StringsKeys.language.tr, style: styleAll),
                        trailing: Icon(
                          Icons.language,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          showCurrencySelectionDialog(context);
                        },
                        title: Text(
                          StringsKeys.displayCurrency.tr,
                          style: styleAll,
                        ),
                        trailing: Icon(
                          Icons.currency_exchange,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            AppRoutesname.legal,
                            arguments: {"title": StringsKeys.legal.tr},
                          );
                        },
                        title: Text(StringsKeys.legal.tr, style: styleAll),
                        trailing: Icon(
                          Icons.gavel_outlined,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          blurDilog(LogoutScreen(), context);
                        },
                        title: Text(StringsKeys.logout.tr, style: styleAll),
                        trailing: Icon(
                          Icons.logout,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 70.h),
      ],
    );
  }
}
