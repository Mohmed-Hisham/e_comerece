import 'dart:io';

import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Preview
            if (controller.selectedImage != null)
              _buildImagePreview(controller.selectedImage!),
            Row(
              children: [
                // Image picker button
                IconButton(
                  onPressed: isInputDisabled
                      ? null
                      : () => _showImagePickerOptions(context),
                  icon: FaIcon(
                    FontAwesomeIcons.image,
                    color: isInputDisabled
                        ? Appcolor.gray
                        : Appcolor.primrycolor,
                    size: 22.sp,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      IgnorePointer(
                        ignoring: isInputDisabled,
                        child: Opacity(
                          opacity: isInputDisabled ? 0.5 : 1.0,
                          child: Custtextfeld(
                            focusNode: controller.focusNode,
                            validator: (val) {
                              // Allow empty text if image is selected
                              if (controller.selectedImage != null) return null;
                              return vlidateInPut(
                                val: val!,
                                min: 1,
                                max: 100000,
                              );
                            },
                            minLines: 2,
                            maxLines: 10,
                            hint: isInputDisabled
                                ? StringsKeys.chatEnded.tr
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
                    child: const CircularProgressIndicator(
                      color: Appcolor.primrycolor,
                    ),
                  ),
                  statusrequest: controller.sendMessagestatusrequest,
                  widget: Container(
                    margin: EdgeInsets.only(right: 15.w),
                    child: IconButton(
                      onPressed: isInputDisabled ? null : () => _handleSend(),
                      icon: FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: isInputDisabled ? Appcolor.gray : Appcolor.reed,
                      ),
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

  Widget _buildImagePreview(File image) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Appcolor.gray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Appcolor.primrycolor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              image,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'صورة مرفقة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'اضغط ارسال لإرسال الصورة',
                  style: TextStyle(fontSize: 12.sp, color: Appcolor.gray),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.removeSelectedImage(),
            icon: Icon(Icons.close, color: Appcolor.reed, size: 24.sp),
          ),
        ],
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Appcolor.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'اختر مصدر الصورة',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerOption(
                    icon: Icons.photo_library,
                    label: 'المعرض',
                    onTap: () {
                      Get.back();
                      controller.pickImage();
                    },
                  ),
                  _buildPickerOption(
                    icon: Icons.camera_alt,
                    label: 'الكاميرا',
                    onTap: () {
                      Get.back();
                      controller.pickImageFromCamera();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Appcolor.primrycolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40.sp, color: Appcolor.primrycolor),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Appcolor.primrycolor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSend() async {
    String startReferenceId = "11";
    // Default fallback
    if (controller.serviceRequestDetails != null) {
      startReferenceId = controller.serviceRequestDetails!.requestId.toString();
    } else if (controller.serviceModel != null) {
      startReferenceId = controller.serviceModel!.id.toString();
    }

    // Handling referenceId correctly
    String refId = startReferenceId;

    // If image is selected, upload and send
    if (controller.selectedImage != null) {
      await controller.uploadAndSendImage(
        platform: controller.plateform ?? '',
        referenceid: refId,
      );
    } else if (controller.formkey.currentState!.validate()) {
      // Send text message only
      await controller.sendMessage(
        platform: controller.plateform ?? '',
        referenceid: refId,
        imagelink: "",
      );
    }

    if (controller.chatid == null) {
      controller.scrollToBottom();
    }
  }
}
