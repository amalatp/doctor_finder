// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usersRepository)
const usersRepositoryProvider = UsersRepositoryProvider._();

final class UsersRepositoryProvider
    extends
        $FunctionalProvider<UsersRepository, UsersRepository, UsersRepository>
    with $Provider<UsersRepository> {
  const UsersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersRepositoryHash();

  @$internal
  @override
  $ProviderElement<UsersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsersRepository create(Ref ref) {
    return usersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsersRepository>(value),
    );
  }
}

String _$usersRepositoryHash() => r'e26c495913ee24fe48d4c64df4bed4beabae2a33';

@ProviderFor(loadUserInformation)
const loadUserInformationProvider = LoadUserInformationFamily._();

final class LoadUserInformationProvider
    extends $FunctionalProvider<AsyncValue<AppUser>, AppUser, Stream<AppUser>>
    with $FutureModifier<AppUser>, $StreamProvider<AppUser> {
  const LoadUserInformationProvider._({
    required LoadUserInformationFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadUserInformationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadUserInformationHash();

  @override
  String toString() {
    return r'loadUserInformationProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<AppUser> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AppUser> create(Ref ref) {
    final argument = this.argument as String;
    return loadUserInformation(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadUserInformationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadUserInformationHash() =>
    r'c446bbb6914fc4c2c20ac67f9c19252c02e03de1';

final class LoadUserInformationFamily extends $Family
    with $FunctionalFamilyOverride<Stream<AppUser>, String> {
  const LoadUserInformationFamily._()
    : super(
        retry: null,
        name: r'loadUserInformationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadUserInformationProvider call(String userId) =>
      LoadUserInformationProvider._(argument: userId, from: this);

  @override
  String toString() => r'loadUserInformationProvider';
}

@ProviderFor(loadDoctors)
const loadDoctorsProvider = LoadDoctorsFamily._();

final class LoadDoctorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Doctor>>,
          List<Doctor>,
          Stream<List<Doctor>>
        >
    with $FutureModifier<List<Doctor>>, $StreamProvider<List<Doctor>> {
  const LoadDoctorsProvider._({
    required LoadDoctorsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'loadDoctorsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadDoctorsHash();

  @override
  String toString() {
    return r'loadDoctorsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Doctor>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Doctor>> create(Ref ref) {
    final argument = this.argument as String;
    return loadDoctors(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadDoctorsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadDoctorsHash() => r'1c14d94f547b935ecbdb341addd11779e266c350';

final class LoadDoctorsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Doctor>>, String> {
  const LoadDoctorsFamily._()
    : super(
        retry: null,
        name: r'loadDoctorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadDoctorsProvider call(String specialisation) =>
      LoadDoctorsProvider._(argument: specialisation, from: this);

  @override
  String toString() => r'loadDoctorsProvider';
}
