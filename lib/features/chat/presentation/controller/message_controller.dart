import 'package:doctor_finder/features/chat/data/chat_repository.dart';
import 'package:doctor_finder/features/chat/domain/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_controller.g.dart';

@riverpod
class MessageController extends _$MessageController {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required Message message,
  }) async {
    if (message.message == null || message.message.isEmpty) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final chatRepository = ref.read(chatRepositoryProvider);

      return chatRepository.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
      );
    });
  }
}
