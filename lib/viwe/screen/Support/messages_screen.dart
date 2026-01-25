import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/chat_shimmer.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/screen/Support/message_header_widget.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_input_field.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_messages_list.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_price_approval_handler.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/screen/Support/widget/service_chat_header.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            const PositionedRight1(),
            const PositionedRight2(),
            Column(
              children: [
                SizedBox(height: 110.h),
                if (controller.serviceModel != null)
                  ServiceChatHeader(service: controller.serviceModel!),
                if (controller.serviceRequestDetails != null)
                  ServiceRequestHeader(
                    request: controller.serviceRequestDetails!,
                  ),
                Expanded(
                  child:
                      controller.getMessagestatusrequest ==
                          Statusrequest.loading
                      ? const ChatShimmer()
                      : controller.getMessagestatusrequest ==
                            Statusrequest.failuer
                      ? const Center(child: Text("Error"))
                      : Column(
                          children: [
                            Expanded(
                              child: ChatMessagesList(
                                messages: controller.messageList,
                                scrollController: controller.scrollController,
                              ),
                            ),
                            ChatPriceApprovalHandler(
                              messages: controller.messageList,
                              controller: controller,
                            ),
                            ChatInputField(
                              controller: controller,
                              isInputDisabled: controller.isChatClosed,
                            ),
                          ],
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
