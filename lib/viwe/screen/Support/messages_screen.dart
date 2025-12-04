import 'dart:developer';

import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/shared/widget_shared/chat_shimmer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/screen/Support/widget/service_chat_header.dart';
import 'package:e_comerece/viwe/screen/Support/widget/price_approval_card.dart';
import 'package:e_comerece/viwe/screen/local_serviess/service_order_screen.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
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
                SizedBox(height: 110.h),
                if (controller.serviceModel != null)
                  ServiceChatHeader(service: controller.serviceModel!),
                StreamBuilder<List<Message>>(
                  stream: controller.messagesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(child: ChatShimmer());
                    }
                    if (snapshot.hasError) {
                      return Expanded(
                        child: Center(child: Text("Error: ${snapshot.error}")),
                      );
                    }

                    final messages = snapshot.data ?? [];
                    if (messages.isEmpty) {
                      return const Expanded(
                        child: Center(child: Text("Start a conversation")),
                      );
                    }

                    String? approvedPrice;
                    final regex = RegExp(
                      r"approve price (\d+)",
                      caseSensitive: false,
                    );
                    if (messages.first.message != null) {
                      final match = regex.firstMatch(messages.first.message!);
                      if (match != null) {
                        approvedPrice = match.group(1);
                      }
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              reverse: true,
                              controller: controller.scrollController,
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
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
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
                                            child: Text(
                                              message.message ?? "",
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
                                              custformatDate(
                                                message.createdAt ??
                                                    DateTime.now(),
                                              ),
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
                          if (approvedPrice != null)
                            Hero(
                              tag: controller.serviceModel?.serviceId ?? "",
                              child: PriceApprovalCard(
                                price: approvedPrice,
                                onConfirm: () {
                                  Get.to(
                                    () => const ServiceOrderScreen(),
                                    arguments: {
                                      'service_model': controller.serviceModel,
                                      'quoted_price': double.parse(
                                        approvedPrice!,
                                      ),
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
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
                                log(controller.chatid.toString());
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  if (controller.chatid != null) {
                                    await controller.sendMessage(
                                      platform: controller.plateform ?? '',
                                      referenceid:
                                          controller.serviceModel == null
                                          ? "11"
                                          : controller.serviceModel!.serviceId
                                                .toString(),
                                      imagelink: "",
                                    );
                                  } else {
                                    await controller.sendMessage(
                                      platform: controller.plateform ?? '',
                                      referenceid:
                                          controller.serviceModel == null
                                          ? "11"
                                          : controller.serviceModel!.serviceId
                                                .toString(),
                                      imagelink: "",
                                    );

                                    controller.scrollToBottom();
                                  }
                                }
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: Appcolor.reed,
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
