import 'dart:developer';
import 'dart:convert';
import 'package:e_comerece/core/servises/local_notification_helper.dart';
import 'package:e_comerece/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('BG Handler: Starting...');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('BG Handler: Firebase initialized. Message ID: ${message.messageId}');

    final plugin = FlutterLocalNotificationsPlugin();

    // 1. Initialize plugin
    await LocalNotificationHelper.initializeForBackground(plugin);

    // 2. Create Channel (Critical for Android 8+)
    await LocalNotificationHelper.createChannel(plugin);

    // 3. Extract and Show
    final content = LocalNotificationHelper.extractContent(message);
    log('BG Handler: Content extracted - ${content['title']}');

    await LocalNotificationHelper.showNotification(
      plugin: plugin,
      title: content['title']!,
      body: content['body']!,
      imageUrl: content['imageUrl'],
      payload: jsonEncode(message.data),
    );
    log('BG Handler: Notification shown');
  } catch (e, stack) {
    log('BG Handler Error: $e');
    print('BG Handler Stack: $stack');
  }
}

/// Background notification tap handler - must be top-level function
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  log('notification tapped (background): ${response.payload}');
  // Navigation handled when app opens via getInitialNotification or onMessageOpenedApp
}

/// Main notification service class
class NotifcationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// Initialize all notification services
  static Future<void> initializeNotifications() async {
    // await TopicManager.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background message tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Subscribe to default topics
    // await TopicManager.subscribeToDefaultTopics();

    // Save FCM token to server
    // await TopicManager.saveTokenToServer();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Check for initial notification (app opened from terminated)
    await _getInitialNotification();
  }

  /// Handle foreground message
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    log('Received foreground message: ${message.messageId}');
    final content = LocalNotificationHelper.extractContent(message);
    await LocalNotificationHelper.showNotification(
      plugin: _localNotificationsPlugin,
      title: content['title']!,
      body: content['body']!,
      imageUrl: content['imageUrl'],
      payload: jsonEncode(message.data),
      notificationId: 0,
    );
  }

  /// Handle message opened app (from background)
  static void _handleMessageOpenedApp(RemoteMessage message) {
    log('Message opened app from background: ${message.messageId}');
    handleNotificationNavigation(message.data);
  }

  /// Initialize local notifications plugin
  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('ic_luncher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await LocalNotificationHelper.createChannel(_localNotificationsPlugin);

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      // onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  // /// Handle notification tap (foreground)
  // static void _handleNotificationTap(NotificationResponse response) {
  //   if (response.payload != null) {
  //     log('Notification tapped: ${response.payload}');
  //     try {
  //       final data = jsonDecode(response.payload!) as Map<String, dynamic>;
  //       handleNotificationNavigation(data);
  //     } catch (e) {
  //       log('Error parsing notification payload: $e');
  //     }
  //   }
  // }

  /// Handle notification navigation
  static void handleNotificationNavigation(Map<String, dynamic> data) {
    // NotificationPayloadModel.fromJson(data).navigate();
  }

  /// Get initial notification (app opened from terminated state)
  static Future<void> _getInitialNotification() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      Future.delayed(const Duration(seconds: 1), () {
        handleNotificationNavigation(initialMessage.data);
      });
    }
  }

  // ==================== Public API ====================

  // /// Handle topic switch after login
  // static Future<void> handleLoginTopicSwitch() =>
  //     TopicManager.handleLoginTopicSwitch();

  // /// Handle topic switch after logout
  // static Future<void> handleLogoutTopicSwitch() =>
  //     TopicManager.handleLogoutTopicSwitch();

  // /// Get FCM token
  // static Future<String> getFcmToken() => TopicManager.getFcmToken();

  // /// Subscribe to default topics
  // static Future<void> subscribeToDefaultTopics() =>
  //     TopicManager.subscribeToDefaultTopics();

  // /// Save token to server
  // static Future<void> saveTokenToServer() => TopicManager.saveTokenToServer();
}
