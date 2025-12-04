import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
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
            PositionedAppBar(title: "Support Chat", onPressed: Get.back),

            Column(
              children: [
                SizedBox(height: 90.h),
                Handlingdataviwe(
                  statusrequest: controller.getChatsstatusrequest,
                  widget: Expanded(
                    child: ListView.builder(
                      itemCount: controller.chatList.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chatList[index];
                        bool isUser = chat.lastSender == "user";

                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Appcolor.fourcolor,
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 2,
                            //     blurRadius: 5,
                            //     offset: const Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: ListTile(
                            onTap: () {
                              controller.goToMassagesScreen(chat.chatId!);
                            },
                            title: Text(
                              chat.lastMessage ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isUser
                                        ? Appcolor.black
                                        : Appcolor.primrycolor,
                                  ),
                            ),

                            subtitle: Text(
                              custformatDate(
                                chat.lastMessageTime ?? DateTime.now(),
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
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
