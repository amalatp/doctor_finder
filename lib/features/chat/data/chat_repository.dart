import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/chat/domain/chat.dart';
import 'package:doctor_finder/features/chat/domain/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chat_repository.g.dart';

String getChatId(String userId1, String userId2) {
  final soted = [userId1, userId2]..sort();
  return '${soted[0]}_${soted[1]}';
}

class ChatRepository {
  ChatRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required Message message,
  }) async {
    final chatId = getChatId(senderId, receiverId);
    final chatDoc = _firestore.collection('chats').doc(chatId);
    final messageDOc = chatDoc.collection('messages').doc();
    final now = DateTime.now().toString();

    final updateChat = Chat(
      chatId: chatId,
      lastMessage: message.message,
      time: now,
      userIds: [senderId, receiverId],
    );

    final newMessage = Message(
      messageId: messageDOc.id,
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      message: message.message,
      time: now,
    );

    await _firestore.runTransaction((txn) async {
      final chatSnapshot = await txn.get(chatDoc);

      if (!chatSnapshot.exists) {
        txn.set(chatDoc, updateChat.toMap());
      } else {
        txn.update(chatDoc, {
          'lastMessage': updateChat.lastMessage,
          'time': updateChat.time,
        });
      }
      txn.set(messageDOc, newMessage.toMap());
    });
  }

  Stream<List<Chat>> loadChats(String userId) {
    return _firestore
        .collection('chats')
        .where('userIds', arrayContains: userId)
        .orderBy('time', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Chat.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Message>> loadMessages(String chatId) {
    final chatDoc = _firestore.collection('chats').doc(chatId);
    return chatDoc
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList(),
        );
  }
}

@riverpod
ChatRepository chatRepository(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return ChatRepository(firestore);
}

@riverpod
Stream<List<Chat>> loadChats(Ref ref, String userId) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return chatRepository.loadChats(userId);
}

@riverpod
Stream<List<Message>> loadMessages(Ref ref, String chatId) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return chatRepository.loadMessages(chatId);
}
