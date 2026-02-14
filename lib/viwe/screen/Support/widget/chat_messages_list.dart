import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
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
                  Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (message.senderType == 'bot')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Appcolor.primrycolor,
                            child: Icon(
                              Icons.smart_toy_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser
                              ? Appcolor.soecendcolor
                              : Appcolor.black2,
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
                        child: _buildMessageContent(context, message),
                      ),
                    ],
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

  /// Build message content based on message type
  Widget _buildMessageContent(BuildContext context, Message message) {
    // Check if it's an image message
    final bool isImageMessage =
        message.messageType == 'image' ||
        (message.imageUrl != null && message.imageUrl!.isNotEmpty);

    if (isImageMessage &&
        message.imageUrl != null &&
        message.imageUrl!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: GestureDetector(
              onTap: () => _showFullImage(context, message.imageUrl!),
              child: CachedNetworkImage(
                imageUrl: message.imageUrl!,
                width: 250.w,
                height: 200.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 250.w,
                  height: 200.h,
                  color: Appcolor.gray.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Appcolor.white,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 250.w,
                  height: 200.h,
                  color: Appcolor.gray.withValues(alpha: 0.3),
                  child: Icon(
                    Icons.broken_image,
                    color: Appcolor.white,
                    size: 40.sp,
                  ),
                ),
              ),
            ),
          ),
          // Caption text if exists
          if (message.message != null && message.message!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              message.message!,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Appcolor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      );
    }

    // Text message
    return Text(
      message.message ?? "",
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Appcolor.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Show full image in dialog
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(color: Appcolor.white),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.broken_image,
                  color: Appcolor.white,
                  size: 50.sp,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Appcolor.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Appcolor.white, size: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
