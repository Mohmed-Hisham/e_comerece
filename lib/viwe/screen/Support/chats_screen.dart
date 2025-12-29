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
                    child: ListView.separated(
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
                        // bool isUser = chat.lastSender == "user"; // Not strictly needed for list view styling but good for reference

                        // Determine Icon and Title based on type
                        IconData leadingIcon;
                        String titleText;
                        Color iconBgColor;

                        if (chat.type == 'service') {
                          leadingIcon = Icons.design_services_rounded;
                          titleText = "Service Order";
                          if (chat.referenceId != null) {
                            titleText += " #${chat.referenceId}";
                          }
                          iconBgColor = Appcolor.primrycolor.withOpacity(0.1);
                        } else {
                          leadingIcon = Icons.support_agent_rounded;
                          titleText = "Customer Support";
                          iconBgColor = Appcolor.soecendcolor.withOpacity(0.1);
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16.r),
                              onTap: () {
                                controller.goToMassagesScreen(
                                  chat.chatId!,
                                  chat.type!,
                                  chat.referenceId!,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Row(
                                  children: [
                                    // Leading Icon
                                    CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor: iconBgColor,
                                      child: Icon(
                                        leadingIcon,
                                        color: Appcolor.primrycolor,
                                        size: 24.sp,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),

                                    // Content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Top Row: Title + Time
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  titleText,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Appcolor.black,
                                                        fontSize: 16.sp,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                custformatDate(
                                                  chat.lastMessageTime ??
                                                      DateTime.now(),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Appcolor.gray,
                                                      fontSize: 12.sp,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),

                                          // Bottom Row: Message + Unread Badge (if needed in future)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  chat.lastMessage ??
                                                      "No messages yet",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: Appcolor.gray,
                                                        height: 1.2,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              if (chat.unreadCount != null &&
                                                  chat.unreadCount! > 0)
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: 8.w,
                                                  ),
                                                  padding: EdgeInsets.all(6.w),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Appcolor
                                                            .primrycolor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Text(
                                                    "${chat.unreadCount}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
