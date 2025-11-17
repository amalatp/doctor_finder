// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessageController)
const messageControllerProvider = MessageControllerProvider._();

final class MessageControllerProvider
    extends $AsyncNotifierProvider<MessageController, void> {
  const MessageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messageControllerHash();

  @$internal
  @override
  MessageController create() => MessageController();
}

String _$messageControllerHash() => r'67cac8900d624c2600fb3876292ce63f0a2cad1a';

abstract class _$MessageController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
