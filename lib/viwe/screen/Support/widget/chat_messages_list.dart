import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatMessagesList extends StatelessWidget {
  final List<Message> messages;
  final ScrollController scrollController;

  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(
        child: Text(
          StringsKeys.startConversation.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Appcolor.gray,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return CustomScrollView(
      reverse: true,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverSpacer(40.h),
        SliverList.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            bool isUser = message.senderType == 'user';

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                  bottomLeft: isUser
                      ? Radius.circular(0)
                      : Radius.circular(10.r),
                  bottomRight: isUser
                      ? Radius.circular(10.r)
                      : Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (message.senderType == 'bot')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Appcolor.primrycolor,
                            child: Icon(
                              Icons.smart_toy_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Bot",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  color: Appcolor.gray,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Appcolor.soecendcolor : Appcolor.black2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                        bottomLeft: isUser
                            ? Radius.circular(0)
                            : Radius.circular(10.r),
                        bottomRight: isUser
                            ? Radius.circular(10.r)
                            : Radius.circular(0),
                      ),
                    ),
                    width: 280.w,
                    child: Text(
                      message.message ?? "",
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Appcolor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      custformatDate(message.createdAt ?? DateTime.now()),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
