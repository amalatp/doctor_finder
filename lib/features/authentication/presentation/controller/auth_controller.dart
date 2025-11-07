import 'dart:io';

import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = AsyncError('Ensure all details are filled', StackTrace.current);
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> createAppUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File profileImage,
    required String type,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        type.trim().isEmpty ||
        profileImage == null ||
        location == null ||
        latitude == null ||
        longitude == null) {
      state = AsyncError(
        'Ensure all details & image are selected',
        StackTrace.current,
      );
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.createAppUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        profileImage: profileImage,
        type: type,
        location: location,
        latitude: latitude,
        longitude: longitude,
      );
    });
  }
}
