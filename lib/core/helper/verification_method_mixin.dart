// import 'package:e_comerece/core/helper/send_otp_helper.dart';
// import 'package:e_comerece/viwe/widget/auth/verification_method_dialog.dart';

// /// مثال على كيفية استخدام نظام التحقق المتعدد في الـ Controller
// /// يمكنك استخدام هذا الكود في SignupController أو LoginStepOneController
// mixin VerificationMethodMixin {
//   /// الطريقة المختارة للتحقق
//   VerificationMethod? selectedMethod;

//   /// بيانات التحقق عبر SMS (إذا تم اختيارها)
//   VerificationData? smsVerificationData;

//   /// إظهار دالوج اختيار طريقة التحقق
//   Future<VerificationMethod?> showVerificationMethodDialog({
//     bool showError = false,
//     String? errorMessage,
//   }) async {
//     final method = await VerificationMethodDialog.show(
//       showError: showError,
//       errorMessage: errorMessage,
//     );
//     if (method != null) {
//       selectedMethod = method;
//     }
//     return method;
//   }

//   /// إرسال رمز التحقق حسب الطريقة المختارة
//   ///
//   /// [email] - البريد الإلكتروني
//   /// [phone] - رقم الهاتف
//   /// [onSendEmail] - دالة لإرسال الكود عبر الإيميل (API الخاص بك)
//   /// [onSuccess] - دالة عند النجاح
//   /// [onError] - دالة عند الفشل
//   Future<void> sendVerificationCode({
//     required String email,
//     required String phone,
//     required Future<bool> Function() onSendEmail,
//     required void Function() onSuccess,
//     required void Function(String error) onError,
//   }) async {
//     // إذا لم يتم اختيار طريقة، اعرض الدالوج
//     if (selectedMethod == null) {
//       final method = await showVerificationMethodDialog();
//       if (method == null) return; // المستخدم ألغى
//     }

//     if (selectedMethod == VerificationMethod.sms) {
//       // إرسال عبر SMS
//       await _sendViaSms(
//         phone: phone,
//         email: email,
//         onSendEmail: onSendEmail,
//         onSuccess: onSuccess,
//         onError: onError,
//       );
//     } else {
//       // إرسال عبر Email
//       await _sendViaEmail(
//         onSendEmail: onSendEmail,
//         onSuccess: onSuccess,
//         onError: onError,
//       );
//     }
//   }

//   /// إرسال عبر SMS
//   Future<void> _sendViaSms({
//     required String phone,
//     required String email,
//     required Future<bool> Function() onSendEmail,
//     required void Function() onSuccess,
//     required void Function(String error) onError,
//   }) async {
//     final result = await SendOtpHelper.verifyPhone(phone);

//     if (result.success && result.verificationData != null) {
//       // نجح الإرسال
//       smsVerificationData = result.verificationData;
//       onSuccess();
//     } else {
//       // فشل الإرسال - اعرض دالوج الخطأ مع اقتراح الإيميل
//       if (result.shouldSuggestEmail) {
//         SmsErrorDialog.show(
//           errorMessage: result.userFriendlyError ?? 'فشل إرسال الرمز',
//           onTryAgain: () async {
//             // حاول مرة أخرى عبر SMS
//             await _sendViaSms(
//               phone: phone,
//               email: email,
//               onSendEmail: onSendEmail,
//               onSuccess: onSuccess,
//               onError: onError,
//             );
//           },
//           onUseEmail: () async {
//             // استخدم الإيميل بدلاً من ذلك
//             selectedMethod = VerificationMethod.email;
//             await _sendViaEmail(
//               onSendEmail: onSendEmail,
//               onSuccess: onSuccess,
//               onError: onError,
//             );
//           },
//         );
//       } else {
//         onError(result.userFriendlyError ?? 'فشل إرسال الرمز');
//       }
//     }
//   }

//   /// إرسال عبر Email
//   Future<void> _sendViaEmail({
//     required Future<bool> Function() onSendEmail,
//     required void Function() onSuccess,
//     required void Function(String error) onError,
//   }) async {
//     final success = await onSendEmail();
//     if (success) {
//       onSuccess();
//     } else {
//       onError('فشل إرسال رمز التحقق عبر البريد الإلكتروني');
//     }
//   }

//   /// التحقق من رمز SMS المُدخل
//   Future<bool> verifySmsCode(String code) async {
//     if (smsVerificationData == null) {
//       return false;
//     }

//     final result = await SendOtpHelper.signInWithSmsCode(
//       verificationId: smsVerificationData!.verificationId,
//       smsCode: code,
//     );

//     return result.fold((error) => false, (success) => success);
//   }
// }

// /*
// ===============================================================================
// مثال على كيفية استخدام الـ Mixin في SignupController:
// ===============================================================================

// class SginupControllerimplemnt extends SginupController with VerificationMethodMixin {
  
//   @override
//   sginup() async {
//     var formdate = formState.currentState!;
//     if (formdate.validate()) {
//       statusrequest = Statusrequest.loading;
//       update();
      
//       // أولاً: اختيار طريقة التحقق
//       final method = await showVerificationMethodDialog();
//       if (method == null) {
//         statusrequest = Statusrequest.none;
//         update();
//         return;
//       }

//       if (!Get.isDialogOpen!) {
//         loadingDialog();
//       }

//       // إرسال بيانات التسجيل للسيرفر
//       final response = await authRepoImpl.sginup(
//         AuthData(
//           name: username.text,
//           email: email.text,
//           phone: phone.text,
//           password: passowrd.text,
//           verificationMethod: method.name, // 'sms' أو 'email'
//         ),
//       );

//       final r = response.fold((l) => l, (r) => r);
//       if (Get.isDialogOpen ?? false) Get.back();

//       if (r is AuthModel) {
//         // إرسال رمز التحقق حسب الطريقة المختارة
//         await sendVerificationCode(
//           email: email.text,
//           phone: phone.text,
//           onSendEmail: () async {
//             // هنا يتم إرسال الكود عبر الـ API الخاص بك
//             // السيرفر سيرسل الكود للإيميل
//             return true; // السيرفر أرسل بنجاح
//           },
//           onSuccess: () {
//             showCustomGetSnack(isGreen: true, text: r.message!);
//             Get.offNamed(
//               AppRoutesname.verFiyCodeSignUp,
//               arguments: {
//                 "email": email.text,
//                 "phone": phone.text,
//                 "method": selectedMethod?.name,
//                 "smsVerificationData": smsVerificationData,
//               },
//             );
//           },
//           onError: (error) {
//             showCustomGetSnack(isGreen: false, text: error);
//           },
//         );
//       }
      
//       if (r is Failure) {
//         showCustomGetSnack(isGreen: false, text: r.errorMessage);
//       }

//       statusrequest = Statusrequest.success;
//       update();
//     }
//   }
// }

// ===============================================================================
// */
