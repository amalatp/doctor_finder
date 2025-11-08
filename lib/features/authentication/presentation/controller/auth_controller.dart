import 'dart:developer';
import 'dart:io';

import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
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
    log(
      "Creating App User with details: $email, $name, $phoneNumber, $type, $location, $latitude, $longitude $password $profileImage",
    );
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
      return;
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

  Future<void> createDoctorWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File profileImage,
    required String specialization,
    required String location,
    required double latitude,
    required double longitude,
    required String type,
    required String description,
    required int yearsOfExperience,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        specialization.trim().isEmpty ||
        type.trim().isEmpty ||
        description.trim().isEmpty ||
        yearsOfExperience == null ||
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
      await authRepository.createDoctorWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        profileImage: profileImage,
        specialization: specialization,
        location: location,
        latitude: latitude,
        longitude: longitude,
        type: type,
        description: description,
        yearsOfExperience: yearsOfExperience,
      );
    });
  }
}
