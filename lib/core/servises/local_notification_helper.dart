import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart' as dio_pkg;
import 'package:path_provider/path_provider.dart';

/// Helper class for displaying local notifications
class LocalNotificationHelper {
  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';
  static const String channelDescription =
      'This channel is used for important notifications.';

  /// Show notification with optional image
  static Future<void> showNotification({
    required FlutterLocalNotificationsPlugin plugin,
    required String title,
    required String body,
    String? imageUrl,
    String? payload,
    int? notificationId,
  }) async {
    final details = await _buildNotificationDetails(imageUrl, title, body);

    await plugin.show(
      notificationId ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Build notification details with optional image
  static Future<NotificationDetails> _buildNotificationDetails(
    String? imageUrl,
    String title,
    String body,
  ) async {
    AndroidNotificationDetails androidDetails;
    DarwinNotificationDetails iosDetails;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final filePath = await _downloadImage(imageUrl);
        androidDetails = _buildAndroidDetailsWithImage(title, body, filePath);
        iosDetails = _buildIOSDetailsWithImage(filePath);
      } catch (e) {
        log('Error downloading image: $e');
        androidDetails = _buildDefaultAndroidDetails();
        iosDetails = _buildDefaultIOSDetails();
      }
    } else {
      androidDetails = _buildDefaultAndroidDetails();
      iosDetails = _buildDefaultIOSDetails();
    }

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  static AndroidNotificationDetails _buildAndroidDetailsWithImage(
    String title,
    String body,
    String filePath,
  ) {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: FilePathAndroidBitmap(filePath), // Show image on the right
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(filePath),
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true,
        hideExpandedLargeIcon: false, // Keep the icon visible when expanded
      ),
    );
  }

  static DarwinNotificationDetails _buildIOSDetailsWithImage(String filePath) {
    return DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      attachments: [DarwinNotificationAttachment(filePath)],
    );
  }

  static AndroidNotificationDetails _buildDefaultAndroidDetails() {
    return const AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      priority: Priority.high,
      importance: Importance.max,
    );
  }

  static DarwinNotificationDetails _buildDefaultIOSDetails() {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
  }

  /// Download image and save to temp directory
  static Future<String> _downloadImage(String url) async {
    final directory = await getTemporaryDirectory();
    final filePath =
        '${directory.path}/notification_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final dio = dio_pkg.Dio();
    // Add timeouts to prevent hanging in background/terminated states
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    final response = await dio.get(
      url,
      options: dio_pkg.Options(responseType: dio_pkg.ResponseType.bytes),
    );

    final file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

  /// Extract notification content from RemoteMessage
  /// Prioritizes data fields as requested for data-only backend implementation
  static Map<String, String?> extractContent(RemoteMessage message) {
    final data = message.data;
    log('Notification Data: ${jsonEncode(data)}');
    final notification = message.notification;

    return {
      'title': data['title'] ?? notification?.title ?? 'No Title',
      'body': data['body'] ?? notification?.body ?? 'No Body',
      'imageUrl':
          data['imageUrl'] ??
          notification?.android?.imageUrl ??
          notification?.apple?.imageUrl,
    };
  }

  /// Initialize local notifications plugin for background use
  static Future<void> initializeForBackground(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    // Use 'ic_luncher' (Custom App Icon) from drawable resources
    // as explicitly requested by the user.
    const androidSettings = AndroidInitializationSettings('ic_luncher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await plugin.initialize(settings);
  }

  /// Create notification channel for Android
  static Future<void> createChannel(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            channelId,
            channelName,
            description: channelDescription,
            importance: Importance.max,
          ),
        );
  }
}
