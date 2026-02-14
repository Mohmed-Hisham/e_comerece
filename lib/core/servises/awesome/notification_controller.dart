import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

/// Notification Controller
/// Contains static methods for handling notification events
/// These methods work in ALL app states: Foreground, Background, and Terminated
class NotificationController {
  /// Port name for isolate communication
  static const String _portName = 'notification_action_port';

  /// Flag to check if controller is initialized (running in main isolate)
  static bool _initialized = false;

  /// Receive port for background isolate communication
  static ReceivePort? _receivePort;

  /// Initialize the controller and set up isolate communication
  /// Call this in your main widget's initState
  static void initializeListeners() {
    log('NotificationController: Initializing listeners...');

    // Create receive port for background isolate communication
    _receivePort = ReceivePort();

    // Register the receive port with a unique name
    IsolateNameServer.removePortNameMapping(_portName);
    IsolateNameServer.registerPortWithName(_receivePort!.sendPort, _portName);

    // Listen for messages from background isolate
    // _receivePort!.listen((serializedData) {
    //   log('NotificationController: Received action from background isolate');
    //   final receivedAction = ReceivedAction().fromMap(
    //     serializedData as Map<String, dynamic>,
    //   );
    //   // _handleNotificationAction(receivedAction);
    // });

    // Set the listeners for awesome notifications
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );

    _initialized = true;
    log('NotificationController: Listeners initialized successfully');
  }

  /// Dispose the controller (call when app is closed)
  static void dispose() {
    IsolateNameServer.removePortNameMapping(_portName);
    _receivePort?.close();
    _receivePort = null;
    _initialized = false;
  }

  // ==================== Notification Event Callbacks ====================

  /// Called when a notification is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log(
      'NotificationController: Notification created - ID: ${receivedNotification.id}',
    );
  }

  /// Called when a notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log(
      'NotificationController: Notification displayed - ID: ${receivedNotification.id}',
    );
  }

  /// Called when user dismisses a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log(
      'NotificationController: Notification dismissed - ID: ${receivedAction.id}',
    );
  }

  /// Called when user taps on a notification or action button
  /// THIS IS THE KEY METHOD - Works in ALL app states!
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('========== NOTIFICATION TAP ==========');
    log('NotificationController: Action received - ID: ${receivedAction.id}');
    log('NotificationController: Payload: ${receivedAction.payload}');
    log(
      'NotificationController: Payload type: ${receivedAction.payload.runtimeType}',
    );
    log(
      'NotificationController: Payload isEmpty: ${receivedAction.payload?.isEmpty}',
    );
    log('=======================================');

    // If the controller is not initialized (running in background isolate),
    // send the action to the main isolate via SendPort
    if (!_initialized) {
      log(
        'NotificationController: Running in background isolate, redirecting...',
      );
      final sendPort = IsolateNameServer.lookupPortByName(_portName);
      if (sendPort != null) {
        sendPort.send(receivedAction.toMap());
        return;
      }
      log('NotificationController: SendPort not found, handling directly');
    }

    // Handle the action
    // await _handleNotificationAction(receivedAction);
  }

  // ==================== Private Methods ====================

  /// Handle the notification action and navigate
  // static Future<void> _handleNotificationAction(
  //   ReceivedAction receivedAction,
  // ) async {
  //   log('NotificationController: Handling action...');

  //   final payload = receivedAction.payload;
  //   if (payload == null || payload.isEmpty) {
  //     log('NotificationController: No payload found');
  //     return;
  //   }

  //   // Convert payload to Map<String, dynamic>
  //   final Map<String, dynamic> data = {};
  //   payload.forEach((key, value) {
  //     data[key] = value;
  //   });

  //   log('NotificationController: Navigating with data: $data');

  //   // Use NotificationPayloadModel for navigation
  //   final payloadModel = NotificationPayloadModel.fromJson(data);

  //   // Check if navigator is available
  //   if (navigatorKey.currentState == null) {
  //     log('NotificationController: Navigator not ready, waiting...');
  //     // Wait for navigator to be ready (for terminated state)
  //     await Future.delayed(const Duration(milliseconds: 500));

  //     if (navigatorKey.currentState == null) {
  //       log('NotificationController: Navigator still not ready after delay');
  //       return;
  //     }
  //   }

  //   // Navigate using the existing payload model
  //   payloadModel.navigate();
  //   log('NotificationController: Navigation triggered');
  // }

  /// Check and handle initial notification action (for terminated state)
  /// Call this after the app is fully initialized
  static Future<void> checkInitialNotification() async {
    log('NotificationController: Checking for initial notification...');

    final receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);

    if (receivedAction != null) {
      log(
        'NotificationController: Found initial notification - ID: ${receivedAction.id}',
      );
      // await _handleNotificationAction(receivedAction);
    } else {
      log('NotificationController: No initial notification found');
    }
  }
}
