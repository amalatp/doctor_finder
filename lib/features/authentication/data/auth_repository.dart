import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
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
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profile  Images')
        .child(cred.user!.uid);

    final snapshot = await firebaseStorageRef.putFile(profileImage);

    final profileImageUrl = await snapshot.ref.getDownloadURL();

    final firebaseFirestore = FirebaseFirestore.instance;
    final appUser = AppUser(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      imageUrl: profileImageUrl,
      location: location,
      latitude: latitude,
      longitude: longitude,
      userId: cred.user!.uid,
      type: type,
    );

    await firebaseFirestore
        .collection('users')
        .doc(cred.user!.uid)
        .set(appUser.toMap());
  }

  Future<void> createDoctorWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File profileImage,
    required String type,
    required String location,
    required double latitude,
    required double longitude,
    required String specialization,
    required String description,
    required int yearsOfExperience,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profile  Images')
        .child(cred.user!.uid);

    final snapshot = await firebaseStorageRef.putFile(profileImage);
    final profileImageUrl = await snapshot.ref.getDownloadURL();

    final doctor = Doctor(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      imageUrl: profileImageUrl,
      location: location,
      latitude: latitude,
      longitude: longitude,
      userId: cred.user!.uid,
      type: type,
      specialization: specialization,
      description: description,
      yearsOfExperience: yearsOfExperience,
    );

    final firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('users')
        .doc(cred.user!.uid)
        .set(doctor.toMap());
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
