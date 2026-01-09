import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/chat_shimmer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/screen/Support/message_header_widget.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_input_field.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_messages_list.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_price_approval_handler.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/screen/Support/widget/service_chat_header.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
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
            PositionedRight1(),
            PositionedRight2(),
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
                  child: StreamBuilder<List<Message>>(
                    stream: controller.messagesStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ChatShimmer();
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Error"));
                      }

                      final messages = snapshot.data ?? [];

                      // Check if chat is ended based on last message
                      bool isChatEndedMessage =
                          messages.isNotEmpty &&
                          (messages.first.message?.toLowerCase().trim() ==
                              'chat ended');

                      bool isInputDisabled =
                          controller.isChatClosed || isChatEndedMessage;

                      return Column(
                        children: [
                          Expanded(
                            child: ChatMessagesList(
                              messages: messages,
                              scrollController: controller.scrollController,
                            ),
                          ),
                          ChatPriceApprovalHandler(
                            messages: messages,
                            controller: controller,
                          ),
                          ChatInputField(
                            controller: controller,
                            isInputDisabled: isInputDisabled,
                          ),
                        ],
                      );
                    },
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
