import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/chat_shimmer.dart';
import 'package:e_comerece/core/constant/color.dart';
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
                            // Typing Indicator
                            if (controller.isOtherUserTyping)
                              const TypingIndicator(),
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

/// Typing indicator widget
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12.r,
            backgroundColor: Appcolor.primrycolor.withValues(alpha: 0.1),
            child: Icon(
              Icons.support_agent,
              size: 14.sp,
              color: Appcolor.primrycolor,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Appcolor.black2,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final delay = index * 0.2;
                    final animValue = ((_animation.value + delay) % 1.0 * 2 - 1)
                        .abs();
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Transform.translate(
                        offset: Offset(0, -4 * (1 - animValue)),
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: Appcolor.white.withValues(
                              alpha: 0.5 + 0.5 * animValue,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
