import 'dart:developer';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  final SupabaseClient client = Supabase.instance.client;

  // Stream for real-time messages
  Stream<List<Map<String, dynamic>>> getMessagesStream(String chatId) {
    return client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: false);
  }

  // Send a text message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    String senderType = 'user',
    String messageType = 'text',
    String? imageUrl,
  }) async {
    try {
      await client.from('messages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'content': content,
        'sender_type': senderType,
        'message_type': messageType,
        'image_url': imageUrl,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  // Send an image message
  Future<void> sendImageMessage({
    required String chatId,
    required String senderId,
    required String imageUrl,
    String? content,
    String senderType = 'user',
  }) async {
    try {
      await client.from('messages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'content': content,
        'sender_type': senderType,
        'message_type': 'image',
        'image_url': imageUrl,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to send image: $e');
    }
  }

  // Subscribe to real-time changes manually if needed
  RealtimeChannel subscribeToChat(
    String chatId,
    void Function(dynamic) onData,
  ) {
    final channel = client.channel('public:messages:chat_id=eq.$chatId');

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: chatId,
          ),
          callback: (payload) {
            onData(payload);
          },
        )
        .subscribe();

    return channel;
  }

  Future<void> unsubscribeFromChat(RealtimeChannel channel) async {
    await client.removeChannel(channel);
  }

  // ==================== CHATS SERVICE ====================

  // Create a new chat
  Future<Map<String, dynamic>?> createChat({
    required String userId,
    String? adminId,
    String? type,
    String? referenceId,
    String? lastMessage,
    String? lastSenderType,
  }) async {
    try {
      final response = await client
          .from('chats')
          .insert({
            'user_id': userId,
            'admin_id': adminId,
            'type': type,
            'reference_id': referenceId,
            'status': 'open',
            'unread_user': 0,
            'unread_admin': 0,
          })
          .select()
          .single();
      return response;
    } catch (e) {
      log(e.toString());
      // Get.snackbar('Error', 'Failed to create chat: $e');
      return null;
    }
  }

  // Get chat by ID
  Future<Map<String, dynamic>?> getChatById(String chatId) async {
    try {
      final response = await client
          .from('chats')
          .select()
          .eq('id', chatId)
          .single();
      return response;
    } catch (e) {
      return null;
    }
  }

  // Get all chats for a user
  Future<List<Map<String, dynamic>>> getUserChats(String userId) async {
    try {
      final response = await client
          .from('chats')
          .select()
          .eq('user_id', userId)
          .order('updated_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // Get all chats for admin
  // Future<List<Map<String, dynamic>>> getAdminChats({String? adminId}) async {
  //   try {
  //     var query = client.from('chats').select();
  //     if (adminId != null) {
  //       query = query.eq('admin_id', adminId);
  //     }
  //     final response = await query.order('updated_at', ascending: false);
  //     return List<Map<String, dynamic>>.from(response);
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // Stream for real-time chats updates
  // Stream<List<Map<String, dynamic>>> getChatsStream(String userId) {
  //   return client
  //       .from('chats')
  //       .stream(primaryKey: ['id'])
  //       .eq('user_id', userId)
  //       .order('updated_at', ascending: false);
  // }

  // // Update chat last message
  // Future<void> updateChatLastMessage({
  //   required String chatId,
  //   required String lastMessage,
  //   required String lastSenderType,
  // }) async {
  //   try {
  //     await client
  //         .from('chats')
  //         .update({
  //           'last_message': lastMessage,
  //           'last_sender_type': lastSenderType,
  //           'updated_at': DateTime.now().toIso8601String(),
  //         })
  //         .eq('id', chatId);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update chat: $e');
  //   }
  // }

  // Update unread count
  Future<void> updateUnreadCount({
    required String chatId,
    required bool isAdmin,
    int? count,
    bool increment = true,
  }) async {
    try {
      final column = isAdmin ? 'unread_admin' : 'unread_user';
      if (count != null) {
        await client
            .from('chats')
            .update({
              column: count,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', chatId);
      } else if (increment) {
        final chat = await getChatById(chatId);
        if (chat != null) {
          final currentCount = chat[column] ?? 0;
          await client
              .from('chats')
              .update({
                column: currentCount + 1,
                'updated_at': DateTime.now().toIso8601String(),
              })
              .eq('id', chatId);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update unread count: $e');
    }
  }

  // Mark chat as read
  // Future<void> markChatAsRead({
  //   required String chatId,
  //   required bool isAdmin,
  // }) async {
  //   try {
  //     final column = isAdmin ? 'unread_admin' : 'unread_user';
  //     await client.from('chats').update({column: 0}).eq('id', chatId);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to mark as read: $e');
  //   }
  // }

  // Update chat status
  Future<void> updateChatStatus({
    required String chatId,
    required String status,
  }) async {
    try {
      await client
          .from('chats')
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', chatId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e');
    }
  }

  // Assign admin to chat
  // Future<void> assignAdminToChat({
  //   required String chatId,
  //   required String adminId,
  // }) async {
  //   try {
  //     await client
  //         .from('chats')
  //         .update({
  //           'admin_id': adminId,
  //           'updated_at': DateTime.now().toIso8601String(),
  //         })
  //         .eq('id', chatId);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to assign admin: $e');
  //   }
  // }

  // Get or create chat
  Future<Map<String, dynamic>?> getOrCreateChat({
    required String userId,
    String? type,
    String? referenceId,
  }) async {
    try {
      // Try to find existing open chat
      var query = client
          .from('chats')
          .select()
          .eq('user_id', userId)
          .eq('status', 'open');

      if (type != null) {
        query = query.eq('type', type);
      }
      if (referenceId != null) {
        query = query.eq('reference_id', referenceId);
      }

      final existing = await query.maybeSingle();

      if (existing != null) {
        return existing;
      }

      // Create new chat if not found
      return await createChat(
        userId: userId,
        type: type,
        referenceId: referenceId,
      );
    } catch (e) {
      log(e.toString());
      // Get.snackbar('Error', 'Failed to get or create chat: $e');
      return null;
    }
  }

  // Delete chat
  Future<void> deleteChat(String chatId) async {
    try {
      // Delete messages first
      await client.from('messages').delete().eq('chat_id', chatId);
      // Then delete chat
      await client.from('chats').delete().eq('id', chatId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete chat: $e');
    }
  }
}
