import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/chat/domain/chat.dart';
import 'package:doctor_finder/features/chat/domain/conversation_args.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatItem extends ConsumerWidget {
  const ChatItem({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final recieverId = chat.userIds.firstWhere((id) => id != userId);
    final userDataAsync = ref.watch(loadUserInformationProvider(recieverId));
    return AsyncValueWidget<AppUser>(
      value: userDataAsync,
      data: (userData) {
        return ListTile(
          onTap: () {
            context.pushNamed(
              AppRoutes.converstation.name,
              extra: ConversationArgs(
                currentUserId: userId,
                recieverId: recieverId,
                recieverName: userData.name,
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userData.imageUrl),
            radius: 30,
          ),
          title: Text(userData.name),
          subtitle: Text(chat.lastMessage),
          trailing: Text(formattedDate(chat.time)),
        );
      },
    );
  }
}
