import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/string_const.dart';
import 'package:e_comerece/core/funcations/sanitize_topic.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';
import 'package:e_comerece/data/repository/Auth_Repo/auth_repo_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Helper لمعالجة نجاح تسجيل الدخول/التسجيل
/// يُستخدم في LoginController و VeirfycodesignupController
class AuthSuccessHandler {
  static final MyServises _myServises = Get.find();
  static final AuthRepoImpl _authRepoImpl = AuthRepoImpl(
    apiService: Get.find(),
  );

  /// معالجة نجاح الـ Auth (Login أو Signup)
  /// - حفظ بيانات المستخدم
  /// - الاشتراك في الـ Topics
  /// - الانتقال للصفحة المناسبة
  /// - تحديث FCM Token
  static Future<void> handleAuthSuccess(AuthData authData) async {
    // 1️⃣ حفظ بيانات المستخدم
    await _saveUserData(authData);

    // 2️⃣ الاشتراك في Firebase Topics
    _subscribeToTopics(authData.email!);

    // 3️⃣ الانتقال للصفحة المناسبة
    _navigateToNextScreen();

    // 4️⃣ تحديث FCM Token في الخلفية
    _updateFcmToken();
  }

  /// حفظ بيانات المستخدم في Secure Storage
  static Future<void> _saveUserData(AuthData authData) async {
    await _myServises.saveSecureData(token, authData.token!);
    await _myServises.saveSecureData(userName, authData.name!);
    await _myServises.saveSecureData(userEmail, authData.email!);
    await _myServises.saveSecureData(userPhone, authData.phone ?? '');
  }

  /// الاشتراك في Firebase Messaging Topics
  static void _subscribeToTopics(String email) {
    FirebaseMessaging.instance.subscribeToTopic("users");
    FirebaseMessaging.instance.subscribeToTopic(sanitizeTopic("user$email"));
  }

  /// الانتقال للصفحة المناسبة
  static void _navigateToNextScreen() {
    if (_myServises.sharedPreferences.getString("step") == "1") {
      Get.offNamed(AppRoutesname.homepage);
    } else {
      Get.offNamed(AppRoutesname.onBoarding);
    }
    _myServises.saveStep("2");
  }

  /// تحديث FCM Token
  static Future<void> _updateFcmToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        String? savedToken = await _myServises.getSecureData("fcm_token");
        if (savedToken != fcmToken) {
          final response = await _authRepoImpl.updateFcmToken(fcmToken);
          response.fold(
            (failure) => debugPrint(
              "Failed to update FCM token: ${failure.errorMessage}",
            ),
            (success) async {
              await _myServises.saveSecureData("fcm_token", fcmToken);
              debugPrint("FCM token updated successfully");
            },
          );
        }
      }
    } catch (e) {
      debugPrint("Error updating token: $e");
    }
  }
}
