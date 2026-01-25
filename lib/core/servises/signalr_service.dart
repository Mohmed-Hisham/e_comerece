import 'dart:async';
import 'dart:developer';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService extends GetxService {
  late HubConnection hubConnection;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  // Constructor is now empty as _initializeHub is moved to onInit
  SignalRService();

  @override
  void onInit() {
    super.onInit();
    _initializeHub(); // Only initialize, don't connect yet
  }

  void _initializeHub() {
    log("SignalR: Initializing with URL: ${ApisUrl.chatHub}");
    final url = ApisUrl.chatHub;
    log("SignalR: Final URL to use: $url");
    hubConnection = HubConnectionBuilder()
        .withUrl(url)
        .withAutomaticReconnect()
        .build();

    hubConnection.onclose(
      ({error}) => log("SignalR: Connection Closed. Error: $error"),
    );
    hubConnection.onreconnecting(
      ({error}) => log("SignalR: Reconnecting... Error: $error"),
    );
    hubConnection.onreconnected(
      ({connectionId}) => log("SignalR: Reconnected. ID: $connectionId"),
    );

    _registerChatHandlers();
  }

  Future<void> startHubConnection() async {
    try {
      if (hubConnection.state == HubConnectionState.Connected) return;

      log("SignalR: Hub starting at ${ApisUrl.chatHub}..."); // Modified logging
      await hubConnection.start();
      log("SignalR: Hub started successfully. State: ${hubConnection.state}");
    } catch (e) {
      log(
        "SignalR: Failed to start Hub. URL: ${ApisUrl.chatHub}. Error: $e",
      ); // Modified logging
    }
  }

  void _registerChatHandlers() {
    hubConnection.on('ReceiveMessage', (arguments) {
      log("New Message Received: $arguments");
      if (arguments != null && arguments.isNotEmpty) {
        _messageController.add({
          'type': 'ReceiveMessage',
          'data': arguments[0],
        });
      }
    });

    hubConnection.on('ErrorMessage', (arguments) {
      log("SignalR Error: ${arguments?[0]}");
    });
  }

  Future<void> joinChat(String chatId) async {
    try {
      // If not connected, try to start first
      if (hubConnection.state != HubConnectionState.Connected) {
        log("SignalR: Attempting to connect before joining group...");
        await startHubConnection();
      }

      if (hubConnection.state == HubConnectionState.Connected) {
        await hubConnection.invoke('JoinChat', args: [chatId]);
        log('Joined Chat Group: $chatId');
      } else {
        log(
          "Cannot join chat: SignalR not connected. State: ${hubConnection.state}",
        );
      }
    } catch (e) {
      log('Error joining chat: $e');
    }
  }

  Future<void> sendChatMessage(Map<String, dynamic> messageDto) async {
    try {
      log("SignalR: Sending message DTO: $messageDto");
      if (hubConnection.state != HubConnectionState.Connected) {
        log("SignalR: Attempting to connect before sending message...");
        await startHubConnection();
      }

      if (hubConnection.state == HubConnectionState.Connected) {
        await hubConnection.invoke('SendMessage', args: [messageDto]);
        log('Message sent via SignalR');
      } else {
        log(
          "Cannot send message: SignalR not connected. State: ${hubConnection.state}",
        );
      }
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  @override
  void onClose() {
    hubConnection.stop();
    _messageController.close();
    super.onClose();
  }
}
