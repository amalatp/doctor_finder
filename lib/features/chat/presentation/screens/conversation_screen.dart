import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/chat/data/chat_repository.dart';
import 'package:doctor_finder/features/chat/domain/message.dart';
import 'package:doctor_finder/features/chat/presentation/controller/message_controller.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/date_formatter.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({
    super.key,
    required this.currentUserId,
    required this.recieverId,
    required this.recieverName,
  });

  final String currentUserId;
  final String recieverId;
  final String recieverName;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatId = getChatId(widget.currentUserId, widget.recieverId);
    final messageAsyncValue = ref.watch(loadMessagesProvider(chatId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat with ${widget.recieverName}",
          style: AppStyles.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AsyncValueWidget(
              value: messageAsyncValue,
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Text("No messages yet. Start the conversation!"),
                  );
                } else {
                  return ListView.builder(
                    // reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final senderId = message.senderId;
                      final isMe = senderId == widget.currentUserId;
                      return _buildMessge(isMe: isMe, message: message);
                    },
                  );
                }
              },
            ),
          ),
          _buildMessageComposer(messageController, chatId),
        ],
      ),
    );
  }

  Widget _buildMessge({required bool isMe, required Message message}) {
    return Container(
      width: SizeCofig.screenWidth * 0.75,
      decoration: BoxDecoration(
        color: isMe ? AppStyles.mainColor : Colors.grey,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              )
            : BorderRadius.only(
                bottomLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      margin: isMe
          ? const EdgeInsets.only(bottom: 8, top: 8, left: 8)
          : const EdgeInsets.only(bottom: 8, top: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate(message.time.toString()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer(
    TextEditingController messageController,
    String chatId,
  ) {
    final state = ref.read(messageControllerProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.message, size: 25, color: AppStyles.mainColor),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: state.isLoading
                ? CircularProgressIndicator()
                : Icon(Icons.send, size: 25, color: AppStyles.mainColor),
            onPressed: () {
              final senderId = widget.currentUserId;
              final receiverId = widget.recieverId;

              final message = Message(
                senderId: senderId,
                receiverId: receiverId,
                message: messageController.text,
                time: DateTime.now().toString(),
                chatId: chatId,
              );

              ref
                  .read(messageControllerProvider.notifier)
                  .sendMessage(
                    senderId: senderId,
                    receiverId: receiverId,
                    message: message,
                  );

              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
