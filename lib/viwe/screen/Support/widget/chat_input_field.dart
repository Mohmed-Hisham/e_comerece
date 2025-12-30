import 'dart:developer';

import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatInputField extends StatelessWidget {
  final SupportScreenControllerImp controller;
  final bool isInputDisabled;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.isInputDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: controller.formkey,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  IgnorePointer(
                    ignoring: isInputDisabled,
                    child: Opacity(
                      opacity: isInputDisabled ? 0.5 : 1.0,
                      child: Custtextfeld(
                        validator: (val) {
                          return vlidateInPut(val: val!, min: 1, max: 100000);
                        },
                        minLines: 2,
                        maxLines: 10,
                        hint: isInputDisabled
                            ? "تم إنهاء المحادثة"
                            : StringsKeys.yourMessage.tr,
                        controller: controller.messsageController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Handlingdataviwe(
              shimmer: Container(
                margin: EdgeInsets.only(right: 15.w),
                width: 40.w,
                height: 40.h,
                child: CircularProgressIndicator(color: Appcolor.primrycolor),
              ),
              statusrequest: controller.sendMessagestatusrequest,
              widget: Container(
                margin: EdgeInsets.only(right: 15.w),
                child: IconButton(
                  onPressed: isInputDisabled
                      ? null
                      : () async {
                          log(controller.chatid.toString());
                          if (controller.formkey.currentState!.validate()) {
                            // Sending logic
                            String startReferenceId = "11";
                            // Default fallback
                            if (controller.serviceRequestDetails != null) {
                              startReferenceId = controller
                                  .serviceRequestDetails!
                                  .requestId
                                  .toString();
                            } else if (controller.serviceModel != null) {
                              startReferenceId = controller
                                  .serviceModel!
                                  .serviceId
                                  .toString();
                            }

                            // Handling referenceId correctly
                            String refId = startReferenceId;

                            await controller.sendMessage(
                              platform: controller.plateform ?? '',
                              referenceid: refId,
                              imagelink: "",
                            
                            );
                            if (controller.chatid == null) {
                              controller.scrollToBottom();
                            }
                          }
                        },
                  icon: FaIcon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: isInputDisabled ? Appcolor.gray : Appcolor.reed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
