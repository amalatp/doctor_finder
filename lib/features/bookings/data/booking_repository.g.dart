// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingRepository)
const bookingRepositoryProvider = BookingRepositoryProvider._();

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
  const BookingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingRepository create(Ref ref) {
    return bookingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingRepository>(value),
    );
  }
}

String _$bookingRepositoryHash() => r'341c62ccda0034e67a95e5ad20f1e37adfe3df76';

@ProviderFor(loadUserBookings)
const loadUserBookingsProvider = LoadUserBookingsFamily._();

final class LoadUserBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          Stream<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $StreamProvider<List<Booking>> {
  const LoadUserBookingsProvider._({
    required LoadUserBookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadUserBookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadUserBookingsHash();

  @override
  String toString() {
    return r'loadUserBookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Booking>> create(Ref ref) {
    final argument = this.argument as String;
    return loadUserBookings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadUserBookingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadUserBookingsHash() => r'f722a649374ad52841cdeec087e288ccf9843b77';

final class LoadUserBookingsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Booking>>, String> {
  const LoadUserBookingsFamily._()
    : super(
        retry: null,
        name: r'loadUserBookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadUserBookingsProvider call(String userId) =>
      LoadUserBookingsProvider._(argument: userId, from: this);

  @override
  String toString() => r'loadUserBookingsProvider';
}

@ProviderFor(loadDoctorBookings)
const loadDoctorBookingsProvider = LoadDoctorBookingsFamily._();

final class LoadDoctorBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          Stream<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $StreamProvider<List<Booking>> {
  const LoadDoctorBookingsProvider._({
    required LoadDoctorBookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadDoctorBookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadDoctorBookingsHash();

  @override
  String toString() {
    return r'loadDoctorBookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Booking>> create(Ref ref) {
    final argument = this.argument as String;
    return loadDoctorBookings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadDoctorBookingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadDoctorBookingsHash() =>
    r'3eccc8c86009f3759fe3a1615f354be38c4e43c5';

final class LoadDoctorBookingsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Booking>>, String> {
  const LoadDoctorBookingsFamily._()
    : super(
        retry: null,
        name: r'loadDoctorBookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadDoctorBookingsProvider call(String doctorId) =>
      LoadDoctorBookingsProvider._(argument: doctorId, from: this);

  @override
  String toString() => r'loadDoctorBookingsProvider';
}
