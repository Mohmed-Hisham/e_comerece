import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/send_otp_helper.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// دالوج لاختيار طريقة إرسال رمز التحقق (SMS أو Email)
class VerificationMethodDialog extends StatelessWidget {
  final Function(VerificationMethod) onMethodSelected;
  final bool showError;
  final String? errorMessage;

  const VerificationMethodDialog({
    super.key,
    required this.onMethodSelected,
    this.showError = false,
    this.errorMessage,
  });

  /// إظهار الدالوج
  static Future<VerificationMethod?> show({
    bool showError = false,
    String? errorMessage,
  }) async {
    return await Get.dialog<VerificationMethod>(
      VerificationMethodDialog(
        onMethodSelected: (method) => Get.back(result: method),
        showError: showError,
        errorMessage: errorMessage,
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // العنوان
            Text(
              StringsKeys.chooseVerificationMethod.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // رسالة توضيحية
            Text(
              StringsKeys.verificationMethodBody.tr,
              style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
              textAlign: TextAlign.center,
            ),

            // إظهار رسالة الخطأ إذا وجدت
            if (showError && errorMessage != null) ...[
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade700,
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                StringsKeys.tryAnotherMethod.tr,
                style: TextStyle(fontSize: 12.sp, color: Appcolor.gray),
                textAlign: TextAlign.center,
              ),
            ],

            SizedBox(height: 20.h),

            // زر SMS
            _MethodButton(
              icon: Icons.sms_outlined,
              title: StringsKeys.sendViaSms.tr,
              subtitle: StringsKeys.sendViaSmsDesc.tr,
              onTap: () => onMethodSelected(VerificationMethod.sms),
            ),

            SizedBox(height: 12.h),

            // زر Email
            _MethodButton(
              icon: Icons.email_outlined,
              title: StringsKeys.sendViaEmail.tr,
              subtitle: StringsKeys.sendViaEmailDesc.tr,
              onTap: () => onMethodSelected(VerificationMethod.email),
              isPrimary: showError, // اجعل الإيميل primary إذا فشل SMS
            ),

            SizedBox(height: 15.h),

            // زر إلغاء
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                StringsKeys.cancel.tr,
                style: TextStyle(color: Appcolor.gray, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// زر اختيار الطريقة
class _MethodButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isPrimary;

  const _MethodButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          color: isPrimary
              ? Appcolor.primrycolor.withValues(alpha: 0.1)
              : Appcolor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isPrimary
                ? Appcolor.primrycolor
                : Appcolor.gray.withValues(alpha: 0.3),
            width: isPrimary ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isPrimary
                    ? Appcolor.primrycolor.withValues(alpha: 0.2)
                    : Appcolor.gray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: isPrimary ? Appcolor.primrycolor : Appcolor.gray,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isPrimary ? Appcolor.primrycolor : Appcolor.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11.sp, color: Appcolor.gray),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isPrimary ? Appcolor.primrycolor : Appcolor.gray,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

/// دالوج عرض خطأ SMS مع اقتراح استخدام الإيميل
class SmsErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onTryAgain;
  final VoidCallback onUseEmail;

  const SmsErrorDialog({
    super.key,
    required this.errorMessage,
    required this.onTryAgain,
    required this.onUseEmail,
  });

  /// إظهار الدالوج
  static Future<void> show({
    required String errorMessage,
    required VoidCallback onTryAgain,
    required VoidCallback onUseEmail,
  }) async {
    await Get.dialog(
      SmsErrorDialog(
        errorMessage: errorMessage,
        onTryAgain: onTryAgain,
        onUseEmail: onUseEmail,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة الخطأ
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.sms_failed_outlined,
                color: Colors.red.shade700,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 15.h),

            // العنوان
            Text(
              StringsKeys.smsSendFailed.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // رسالة الخطأ
            Text(
              errorMessage,
              style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),

            // زر استخدام الإيميل (الأساسي)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  onUseEmail();
                },
                icon: Icon(Icons.email_outlined, size: 20.sp),
                label: Text(
                  StringsKeys.sendViaEmail.tr,
                  style: TextStyle(fontSize: 14.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primrycolor,
                  foregroundColor: Appcolor.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // زر المحاولة مرة أخرى
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.back();
                  onTryAgain();
                },
                icon: Icon(Icons.refresh, size: 20.sp),
                label: Text(
                  StringsKeys.trySmsAgain.tr,
                  style: TextStyle(fontSize: 14.sp),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Appcolor.gray,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  side: BorderSide(color: Appcolor.gray.withValues(alpha: 0.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
