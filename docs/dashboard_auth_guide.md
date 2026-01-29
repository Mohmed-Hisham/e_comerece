# 🔐 دليل تطبيق الـ Authentication للداش بورد

## 📋 نظرة عامة

هذا الدليل يشرح التغييرات اللي عملناها في نظام الـ Authentication في تطبيق الموبايل، عشان تقدر تطبقها في الداش بورد (Login + Create Admin).

---

## 🎯 الفكرة الأساسية

**Smart Input**: المستخدم يقدر يدخل **إيميل** أو **رقم هاتف** في نفس الـ input field، والسيستم يفهم تلقائياً نوع الإدخال ويتصرف على أساسه.

---

## 📁 الملفات اللي محتاج تضيفها/تعدلها

### 1️⃣ `AuthData` Model

أضف حقل `identifier` للـ Model:

```dart
class AuthData {
  AuthData({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.token,
    this.code,
    this.newPassword,
    this.identifier,  // ← جديد: إيميل أو رقم هاتف
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? token;
  final String? code;
  final String? newPassword;
  final String? identifier;  // ← جديد

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      token: json["accessToken"],
      code: json["code"],
      newPassword: json["newPassword"],
    );
  }

  Map<String, dynamic> toJson() => {
    if (name != null) "name": name,
    if (email != null) "email": email,
    if (phone != null) "phone": phone,
    if (token != null) "accessToken": token,
    if (password != null) "password": password,
    if (code != null) "code": code,
    if (newPassword != null) "newPassword": newPassword,
    if (identifier != null) "identifier": identifier,  // ← جديد
  };
}
```

---

### 2️⃣ `InputTypeHelper` (ملف جديد)

أنشئ ملف جديد للتحقق من نوع الإدخال:

```dart
/// Helper للتحقق من نوع الإدخال (هاتف أم إيميل)
class InputTypeHelper {
  /// التحقق مما إذا كان الإدخال رقم هاتف
  static bool isPhoneNumber(String input) {
    // يبدأ بـ + أو أرقام فقط وطوله مناسب لرقم هاتف
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    // إزالة المسافات والشرطات
    final cleanInput = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return phoneRegex.hasMatch(cleanInput);
  }

  /// التحقق مما إذا كان الإدخال بريد إلكتروني
  static bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input.trim());
  }

  /// تنظيف رقم الهاتف وإضافة كود الدولة إذا لزم الأمر
  static String formatPhoneNumber(
    String phone, {
    String defaultCountryCode = '+20',  // مصر
  }) {
    // إزالة المسافات والشرطات
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // إذا لم يبدأ بـ + أضف كود الدولة
    if (!cleanPhone.startsWith('+')) {
      // إذا بدأ بـ 0، أزل الصفر وأضف كود الدولة
      if (cleanPhone.startsWith('0')) {
        cleanPhone = defaultCountryCode + cleanPhone.substring(1);
      } else {
        cleanPhone = defaultCountryCode + cleanPhone;
      }
    }

    return cleanPhone;
  }
}
```

---

### 3️⃣ الـ API Endpoints

```dart
class ApisUrl {
  static const String _baseUrl = 'https://sltukapis-production.up.railway.app/api/v1';
  
  // Auth endpoints
  static const String loginStepOne = '$_baseUrl/Auth/login-step-one';
  static const String loginStepTwo = '$_baseUrl/Auth/login-step-two';
  
  // للداش بورد فقط
  static const String createAdmin = '$_baseUrl/Auth/create-admin';  // أو الـ endpoint بتاعك
}
```

---

### 4️⃣ `AuthRepo` Interface

```dart
abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> loginStepOne(AuthData authData);
  Future<Either<Failure, AuthModel>> loginStepTwo(AuthData authData);
  // للداش بورد
  Future<Either<Failure, AuthModel>> createAdmin(AuthData authData);
}
```

---

### 5️⃣ `AuthRepoImpl`

```dart
class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, AuthModel>> loginStepOne(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.loginStepOne,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> loginStepTwo(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.loginStepTwo,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

---

## 🔄 كيف يشتغل الـ Login (Two-Step)

### الخطوة 1: `loginStepOne`

```dart
// في الـ Controller
loginStepOne() async {
  final input = emailController.text.trim();
  
  // 1. تحديد نوع الإدخال
  final isPhone = InputTypeHelper.isPhoneNumber(input);
  
  // 2. إرسال للسيرفر
  final response = await authRepoImpl.loginStepOne(
    AuthData(identifier: input),  // ← نرسل identifier مش email
  );
  
  final r = response.fold((l) => l, (r) => r);
  
  if (r is AuthModel && r.success == true) {
    if (isPhone) {
      // 🔹 الإدخال رقم هاتف → السيرفر هيرسل SMS
      // لازم تستخدم Firebase Phone Auth
      final phoneNumber = r.authData?.phone ?? InputTypeHelper.formatPhoneNumber(input);
      
      // إرسال OTP عبر Firebase (شوف القسم التالي)
      // ...
      
    } else {
      // 🔹 الإدخال إيميل → السيرفر أرسل الكود للإيميل
      // روح لصفحة إدخال الكود
      navigateToCodeVerification(
        identifier: input,
        isPhone: false,
      );
    }
  }
}
```

### الخطوة 2: `loginStepTwo`

```dart
// بعد ما المستخدم يدخل الكود
login() async {
  // إذا كان التحقق عبر SMS، تحقق من الكود عبر Firebase أولاً
  if (isPhone && verificationId != null) {
    final smsResult = await SendOtpHelper.signInWithSmsCode(
      verificationId: verificationId!,
      smsCode: codeController.text.trim(),
    );
    
    if (smsResult.isLeft()) {
      // الكود غلط
      showError(smsResult.left);
      return;
    }
  }
  
  // الآن أكمل تسجيل الدخول مع السيرفر
  var response = await authRepoImpl.loginStepTwo(
    AuthData(
      identifier: identifier,
      password: passwordController.text,
      code: isPhone ? null : codeController.text,  // ما نرسلش الكود لو SMS
    ),
  );
  
  // handle response...
}
```

---

## 📱 Firebase Phone Auth (للـ SMS)

### إضافة الـ Helper

```dart
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// بيانات التحقق عبر SMS
class VerificationData {
  final String verificationId;
  final int? resendToken;

  VerificationData({required this.verificationId, this.resendToken});
}

class SendOtpHelper {
  /// إرسال OTP عبر رقم الهاتف
  static Future<Either<String, VerificationData>> verifyPhone(
    String phoneNumber, {
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Completer<Either<String, VerificationData>> completer = Completer();

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // التحقق التلقائي تم (نادر في الويب)
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            completer.complete(Left(_getErrorMessage(e.code)));
          }
        },
        codeSent: (String verId, int? resendToken) {
          if (!completer.isCompleted) {
            completer.complete(
              Right(VerificationData(
                verificationId: verId,
                resendToken: resendToken,
              )),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          if (!completer.isCompleted) {
            completer.complete(
              Right(VerificationData(verificationId: verId)),
            );
          }
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(Left('فشل إرسال رمز التحقق'));
      }
    }

    return completer.future;
  }

  /// التحقق من رمز SMS المُدخل
  static Future<Either<String, bool>> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode.trim(),
      );

      await auth.signInWithCredential(credential);
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(_getErrorMessage(e.code));
    } catch (e) {
      return const Left('حدث خطأ غير متوقع');
    }
  }

  static String _getErrorMessage(String? code) {
    switch (code) {
      case 'invalid-phone-number':
        return 'رقم الهاتف غير صحيح';
      case 'too-many-requests':
        return 'تم إرسال طلبات كثيرة، يرجى المحاولة لاحقاً';
      case 'invalid-verification-code':
        return 'رمز التحقق غير صحيح';
      case 'session-expired':
        return 'انتهت صلاحية الجلسة، يرجى المحاولة مرة أخرى';
      default:
        return 'فشل إرسال رمز التحقق';
    }
  }
}
```

---

## 🌐 للداش بورد (Web) - ملاحظات مهمة

### 1. Firebase Phone Auth على الويب
- لازم تفعّل reCAPTCHA
- ممكن يكون أبطأ من الموبايل
- تأكد من تفعيل Phone Auth في Firebase Console

### 2. بديل للـ SMS في الداش بورد
بما إن الداش بورد للـ Admin فقط، ممكن تعتمد على **الإيميل فقط** وتشيل الـ SMS:

```dart
// للداش بورد - إيميل فقط
loginStepOne() async {
  final email = emailController.text.trim();
  
  // التحقق إن الإدخال إيميل
  if (!InputTypeHelper.isEmail(email)) {
    showError('يرجى إدخال بريد إلكتروني صحيح');
    return;
  }
  
  final response = await authRepoImpl.loginStepOne(
    AuthData(identifier: email),
  );
  
  // السيرفر هيرسل كود للإيميل
  // ...
}
```

---

## 📊 ملخص البيانات المرسلة للـ API

### `POST /Auth/login-step-one`
```json
{
  "identifier": "admin@example.com"  // أو "+201234567890"
}
```

**Response:**
```json
{
  "success": true,
  "message": "تم إرسال كود التحقق",
  "data": {
    "email": "admin@example.com",
    "phone": "+201234567890",
    "name": "Admin"
  }
}
```

### `POST /Auth/login-step-two`
```json
{
  "identifier": "admin@example.com",
  "password": "yourpassword",
  "code": "123456"  // null لو SMS (الكود اتحقق منه عبر Firebase)
}
```

**Response:**
```json
{
  "success": true,
  "message": "تم تسجيل الدخول بنجاح",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "name": "Admin",
    "email": "admin@example.com",
    "phone": "+201234567890"
  }
}
```

---

## ✅ Checklist للتطبيق

- [ ] إضافة `identifier` للـ `AuthData` model
- [ ] إنشاء `InputTypeHelper` class
- [ ] تحديث `ApisUrl` بالـ endpoints الجديدة
- [ ] تحديث `AuthRepo` و `AuthRepoImpl`
- [ ] تحديث Login Controller للـ two-step flow
- [ ] (اختياري) إضافة Firebase Phone Auth للـ SMS
- [ ] تحديث الـ UI لدعم "إيميل أو رقم هاتف"

---

## 💡 نصيحة للداش بورد

لو الداش بورد للـ Admin فقط، ممكن تبسط الموضوع:
1. **اعتمد على الإيميل فقط** (بدون SMS)
2. السيرفر يرسل كود للإيميل
3. الـ Admin يدخل الكود + الباسورد
4. تسجيل الدخول

ده أسهل وأأمن للداش بورد! 🚀

---

## 📞 لو عندك أسئلة

راجع الملفات دي في المشروع:
- `lib/data/model/AuthModel/auth_model.dart`
- `lib/core/helper/input_type_helper.dart`
- `lib/core/helper/send_otp_helper.dart`
- `lib/controller/auth/login_step_one_controller.dart`
- `lib/controller/auth/login_controller.dart`
- `lib/data/repository/Auth_Repo/auth_repo_impl.dart`
