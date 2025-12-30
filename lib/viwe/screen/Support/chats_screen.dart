import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_item_widget.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SupportScreenControllerImp()..getChats(),
        builder: (controller) => Stack(
          children: [
            PositionedRight1(),
            PositionedRight2(),
            PositionedAppBar(
              title: StringsKeys.supportChatTitle.tr,
              onPressed: Get.back,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90.h),
                Handlingdataviwe(
                  statusrequest: controller.getChatsstatusrequest,
                  widget: Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 20.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemCount: controller.chatList.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chatList[index];
                        return ChatItemWidget(
                          chat: chat,
                          onTap: () {
                            controller.goToMassagesScreen(
                              chat.chatId!,
                              chat.type!,
                              chat.referenceId!,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
