// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatRepository)
const chatRepositoryProvider = ChatRepositoryProvider._();

final class ChatRepositoryProvider
    extends $FunctionalProvider<ChatRepository, ChatRepository, ChatRepository>
    with $Provider<ChatRepository> {
  const ChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatRepository create(Ref ref) {
    return chatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRepository>(value),
    );
  }
}

String _$chatRepositoryHash() => r'6a60b7246ac4af63bfbd86db839bfa7edbb3935d';

@ProviderFor(loadChats)
const loadChatsProvider = LoadChatsFamily._();

final class LoadChatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Chat>>,
          List<Chat>,
          Stream<List<Chat>>
        >
    with $FutureModifier<List<Chat>>, $StreamProvider<List<Chat>> {
  const LoadChatsProvider._({
    required LoadChatsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadChatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadChatsHash();

  @override
  String toString() {
    return r'loadChatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Chat>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Chat>> create(Ref ref) {
    final argument = this.argument as String;
    return loadChats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadChatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadChatsHash() => r'7d527661ab5fa69a94b7be4e6fd34a048b1128ec';

final class LoadChatsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Chat>>, String> {
  const LoadChatsFamily._()
    : super(
        retry: null,
        name: r'loadChatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadChatsProvider call(String userId) =>
      LoadChatsProvider._(argument: userId, from: this);

  @override
  String toString() => r'loadChatsProvider';
}

@ProviderFor(loadMessages)
const loadMessagesProvider = LoadMessagesFamily._();

final class LoadMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Message>>,
          List<Message>,
          Stream<List<Message>>
        >
    with $FutureModifier<List<Message>>, $StreamProvider<List<Message>> {
  const LoadMessagesProvider._({
    required LoadMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadMessagesHash();

  @override
  String toString() {
    return r'loadMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Message>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Message>> create(Ref ref) {
    final argument = this.argument as String;
    return loadMessages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadMessagesHash() => r'139f1f0c54f3e7ff49f07e93e72f8a12de26d9bb';

final class LoadMessagesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Message>>, String> {
  const LoadMessagesFamily._()
    : super(
        retry: null,
        name: r'loadMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadMessagesProvider call(String chatId) =>
      LoadMessagesProvider._(argument: chatId, from: this);

  @override
  String toString() => r'loadMessagesProvider';
}
