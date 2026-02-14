import 'dart:developer';
import 'package:e_comerece/core/servises/awesome/awesome_notification_service.dart';
import 'package:e_comerece/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('FCM Background Handler: Message received');
  log('FCM Background Handler: Data: ${message.data}');

  // Ensure Firebase is initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // CHECK: If Firebase already showed a notification (has Notification payload),
  // DON'T show another one - this prevents duplicate notifications
  if (message.notification != null) {
    log(
      'FCM Background Handler: Firebase already showed notification, skipping Awesome Notification',
    );
    return;
  }

  // Only create local notification for DATA-ONLY messages
  await _createNotificationFromFcm(message);
}

/// Create notification from FCM message (for data-only messages)
Future<void> _createNotificationFromFcm(RemoteMessage message) async {
  final data = message.data;

  // Get notification content from data
  final title = data['title'] ?? data['notification_title'] ?? '';
  final body = data['body'] ?? data['notification_body'] ?? '';
  final imageUrl = data['imageUrl'] ?? data['image'];

  if (title.isEmpty && body.isEmpty) {
    log('FCM: No title or body, skipping notification');
    return;
  }

  // Convert data to payload (Map<String, String?>)
  final payload = <String, String?>{};
  data.forEach((key, value) {
    payload[key] = value?.toString();
  });

  log('FCM: Creating notification with ID and payload...');
  log('FCM: Payload keys: ${payload.keys.toList()}');
  log('FCM: route=${payload['route']}, targetId=${payload['targetId']}');

  // Create notification with Awesome Notifications
  await AwesomeNotificationService.createNotification(
    id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
    title: title,
    body: body,
    bigPicture: imageUrl,
    payload: payload,
  );

  log('FCM: Notification created with payload: $payload');
}

/// Create notification from FCM message (for FOREGROUND - always show)
Future<void> _createNotificationFromFcmForeground(RemoteMessage message) async {
  final notification = message.notification;
  final data = message.data;

  // Get notification content - prefer notification payload, fallback to data
  final title =
      notification?.title ?? data['title'] ?? data['notification_title'] ?? '';
  final body =
      notification?.body ?? data['body'] ?? data['notification_body'] ?? '';
  final imageUrl =
      notification?.android?.imageUrl ?? data['imageUrl'] ?? data['image'];

  if (title.isEmpty && body.isEmpty) {
    log('FCM Foreground: No title or body, skipping notification');
    return;
  }

  // Convert data to payload (Map<String, String?>)
  final payload = <String, String?>{};
  data.forEach((key, value) {
    payload[key] = value?.toString();
  });

  // Create notification with Awesome Notifications
  await AwesomeNotificationService.createNotification(
    id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
    title: title,
    body: body,
    bigPicture: imageUrl,
    largeIcon: imageUrl,
    payload: payload,
  );

  log('FCM Foreground: Notification created with payload: $payload');
}

/// Awesome FCM Service
/// Handles Firebase Cloud Messaging integration with Awesome Notifications
class AwesomeFcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize FCM with Awesome Notifications
  static Future<void> initialize() async {
    log('AwesomeFcmService: Initializing...');

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    log('AwesomeFcmService: Initialized successfully');
  }

  /// Handle foreground FCM messages
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    log('AwesomeFcmService: Foreground message received');
    log('AwesomeFcmService: Data: ${message.data}');

    // In foreground, Firebase doesn't auto-show notifications
    // So we always create one with Awesome Notifications
    await _createNotificationFromFcmForeground(message);
  }

  /// Handle notification tap when app is in background
  static void _handleMessageOpenedApp(RemoteMessage message) {
    log('AwesomeFcmService: Message opened app from background');
    log('AwesomeFcmService: Data: ${message.data}');
    // Navigation is handled by NotificationController.onActionReceivedMethod
  }

  /// Get the FCM token
  static Future<String?> getToken() async {
    final token = await _messaging.getToken();
    log('AwesomeFcmService: FCM Token: $token');
    return token;
  }

  /// Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    log('AwesomeFcmService: Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    log('AwesomeFcmService: Unsubscribed from topic: $topic');
  }

  /// Request permission (iOS)
  static Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Check for initial message (app opened from terminated via FCM)
  /// Note: With Awesome Notifications, this is handled by getInitialNotificationAction
  static Future<RemoteMessage?> getInitialMessage() async {
    return await _messaging.getInitialMessage();
  }

  // ==================== Topic Management ====================
  //  Subscribe to default topics

  /// Save FCM token to server
}
