import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

/// Awesome Notifications Service
/// Handles all local notification functionality
class AwesomeNotificationService {
  static final AwesomeNotifications _notifications = AwesomeNotifications();

  /// Channel key for basic notifications
  static const String basicChannelKey = 'basic_channel';

  /// Channel key for high importance notifications
  static const String highImportanceChannelKey = 'high_importance_channel';

  /// Initialize Awesome Notifications
  /// Must be called before MaterialApp widget (in main())
  static Future<void> initialize() async {
    log('AwesomeNotificationService: Initializing...');

    await _notifications.initialize(
      // Use null for default app icon, or specify resource icon
      'resource://mipmap/ic_launcher',
      [
        // Basic notification channel
        NotificationChannel(
          channelKey: basicChannelKey,
          channelName: 'Basic Notifications',
          channelDescription: 'Basic notification channel for general updates',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Default,
          channelShowBadge: true,
        ),
        // High importance channel (for orders, offers, etc.)
        NotificationChannel(
          channelKey: highImportanceChannelKey,
          channelName: 'Important Notifications',
          channelDescription:
              'High importance notifications for orders and offers',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
        ),
      ],
      // Channel groups (optional, for visual organization)
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_group',
          channelGroupName: 'Basic Notifications',
        ),
      ],
      debug: true,
    );

    log('AwesomeNotificationService: Initialized successfully');
  }

  /// Request permission to send notifications
  static Future<bool> requestPermission() async {
    final isAllowed = await _notifications.isNotificationAllowed();
    if (!isAllowed) {
      log('AwesomeNotificationService: Requesting permission...');
      return await _notifications.requestPermissionToSendNotifications();
    }
    return true;
  }

  /// Check if notifications are allowed
  static Future<bool> isNotificationAllowed() async {
    return await _notifications.isNotificationAllowed();
  }

  /// Create a local notification (for testing or local triggers)
  static Future<void> createNotification({
    required int id,
    required String title,
    required String body,
    String? channelKey,
    Map<String, String?>? payload,
    String? bigPicture,
    String? largeIcon,
  }) async {
    await _notifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey ?? highImportanceChannelKey,
        title: title,
        body: body,
        payload: payload,
        bigPicture: bigPicture,
        largeIcon: largeIcon,
        notificationLayout: bigPicture != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        actionType: ActionType.Default,
      ),
    );
  }

  /// Get initial notification action (for terminated state)
  /// Call this to check if app was opened by notification
  static Future<ReceivedAction?> getInitialNotificationAction({
    bool removeFromActionEvents = false,
  }) async {
    return await _notifications.getInitialNotificationAction(
      removeFromActionEvents: removeFromActionEvents,
    );
  }

  /// Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Get badge count
  static Future<int> getBadgeCount() async {
    return await _notifications.getGlobalBadgeCounter();
  }

  /// Set badge count
  static Future<void> setBadgeCount(int count) async {
    await _notifications.setGlobalBadgeCounter(count);
  }

  /// Reset badge count
  static Future<void> resetBadgeCount() async {
    await _notifications.resetGlobalBadge();
  }
}
