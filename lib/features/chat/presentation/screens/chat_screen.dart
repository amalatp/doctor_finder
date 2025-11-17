import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/chat/data/chat_repository.dart';
import 'package:doctor_finder/features/chat/domain/chat.dart';
import 'package:doctor_finder/features/chat/presentation/widgets/chat_item.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final chatsAsyncvalue = ref.watch(loadChatsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: Text('Chat', style: AppStyles.titleTextStyle)),
      body: AsyncValueWidget<List<Chat>>(
        value: chatsAsyncvalue,
        data: (chats) {
          if (chats.isEmpty) {
            return Center(child: Text('No chats yet'));
          } else {
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatItem(chat: chat);
              },
            );
          }
        },
      ),
    );
  }
}
