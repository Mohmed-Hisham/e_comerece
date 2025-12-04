import 'package:e_comerece/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Handling a background message ${message.messageId}');
}

// background notification tap callback (لا تستخدم closure هنا)
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  // هذا سينفذ عندما المستخدم يضغط على إشعار في الخلفية/ميت
  print('notification tapped (background): ${response.payload}');
}

class NotifcationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// Initializes Firebase Messaging and local notifications
  static Future<void> initializeNotifications() async {
    await _firebaseMessaging.requestPermission();

    /// Called when massages are received while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a message while in the foreground: ${message.messageId}');
      await _showFlutterNotification(message);
    });

    /// Get and print the FCM token for this device
    await getFcmToken();

    // initialize the local notification plugin
    await _initializeLocalNotifications();

    // Check if app was lunched by tipping on a notification
    await _getInitialNotification();
  }

  /// fetches the FCM token for this device
  static Future<String> getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $token');
    return token!;
  }

  /// shows a local notification when a notification is received
  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic>? data = message.data;

    String title = notification?.title ?? data['title'] ?? 'No Title';
    String body = notification?.body ?? data['body'] ?? 'No Body';

    // android notification config
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
          'CHANNEL_ID',
          'CHANNEL_NAME',
          channelDescription: 'notification channel for bascic test',
          priority: Priority.high,
          importance: Importance.max,
        );

    // ios notification config
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Combine platform-specific settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  /// initializes the local notification system (both android and ios)
  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_luncher');

    const DarwinInitializationSettings iosInt = DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: iosInt,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // مرر دالة top-level بدل closure
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // هذا يشتغل في foreground/background عندما التطبيق مفتوح
        print('Notification tapped: ${response.payload}');
      },
    );
  }

  /// Handles notification tap when app is terminated
  static Future<void> _getInitialNotification() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      // _showFlutterNotification(initialMessage);
      print(
        'App opened from terminated state via notification${initialMessage.data}',
      );
    }
  }
}
