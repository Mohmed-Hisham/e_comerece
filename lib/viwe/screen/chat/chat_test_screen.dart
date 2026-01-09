import 'package:e_comerece/core/servises/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTestScreen extends StatefulWidget {
  const ChatTestScreen({super.key});

  @override
  State<ChatTestScreen> createState() => _ChatTestScreenState();
}

class _ChatTestScreenState extends State<ChatTestScreen> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final TextEditingController _messageController = TextEditingController();
  final String chatId = 'test-chat-id'; // You can change this to dynamic UUID
  final String senderId = 'user-1'; // Replace with actual user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase Real-time Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabaseService.getMessagesStream(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final messages = snapshot.data ?? [];
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isImage = msg['message_type'] == 'image';
                    return ListTile(
                      title: isImage
                          ? (msg['image_url'] != null
                                ? Image.network(
                                    msg['image_url'],
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : const Text('[Image]'))
                          : Text(msg['content'] ?? ''),
                      subtitle: Text(
                        '${msg['sender_id'] ?? ''} (${msg['sender_type'] ?? 'user'})',
                      ),
                      trailing: Text(
                        msg['created_at']?.split('T')[1].substring(0, 5) ?? '',
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      supabaseService.sendMessage(
                        chatId: chatId,
                        content: _messageController.text,
                      );
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
