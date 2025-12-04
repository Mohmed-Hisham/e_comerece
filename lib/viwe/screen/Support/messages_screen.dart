import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupportScreenControllerImp());
    return Scaffold(
      body: GetBuilder<SupportScreenControllerImp>(
        builder: (controller) => Stack(
          children: [
            PositionedRight1(),
            PositionedRight2(),
            Column(
              children: [
                SizedBox(height: 100.h),
                Expanded(
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList.builder(
                        itemCount: controller.messageList.length,
                        itemBuilder: (context, index) {
                          final message = controller.messageList[index];
                          bool isUser = message.senderType == 'user';

                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Column(
                              crossAxisAlignment: isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? Appcolor.soecendcolor
                                        : Appcolor.black2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 280.w,
                                  child: Text(
                                    message.message!,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Appcolor.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    custformatDate(message.createdAt!),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: controller.formkey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              if (controller.showfildName)
                                Custtextfeld(
                                  hint: StringsKeys.yourName.tr,
                                  controller: controller.nameController,
                                ),
                              Custtextfeld(
                                validator: (val) {
                                  return vlidateInPut(
                                    val: val!,
                                    min: 1,
                                    max: 100000,
                                  );
                                },
                                maxLines: 10,
                                hint: StringsKeys.yourMessage.tr,
                                controller: controller.messsageController,
                              ),
                            ],
                          ),
                        ),
                        Handlingdataviwe(
                          shimmer: Container(
                            margin: EdgeInsets.only(right: 15.w),
                            width: 40.w,
                            height: 40.h,
                            child: CircularProgressIndicator(
                              color: Appcolor.primrycolor,
                            ),
                          ),
                          statusrequest: controller.sendMessagestatusrequest,
                          widget: Container(
                            margin: EdgeInsets.only(right: 15.w),

                            child: IconButton(
                              onPressed: () async {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  if (controller.chatid != null) {
                                    await controller.sendMessage(
                                      platform: controller.plateform ?? '',
                                      referenceid: "234",
                                      imagelink: "",
                                      chatid: controller.chatid,
                                    );

                                    await controller.getMessages(
                                      chatid: controller.chatid!,
                                    );
                                  } else {
                                    int? chatid = await controller.sendMessage(
                                      platform: controller.plateform ?? '',
                                      referenceid: "234",
                                      imagelink: "",
                                    );
                                    if (chatid != 0) {
                                      controller.chatid = chatid;
                                      controller.showfildName = false;
                                      await controller.getMessages(
                                        chatid: chatid,
                                      );
                                    }
                                  }
                                }
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: Appcolor.primrycolor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            PositionedAppBar(
              title: StringsKeys.messages.tr,
              onPressed: Get.back,
            ),
          ],
        ),
      ),
    );
  }
}
