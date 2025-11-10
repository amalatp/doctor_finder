import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'users_repository.g.dart';

class UsersRepository {
  UsersRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<AppUser> loadUserInformation(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (!snapshot.exists) {
        throw Exception('User not found');
      }
      final data = snapshot.data()!;
      if (data['type'] == 'User') {
        return AppUser.fromMap(data);
      } else {
        return Doctor.fromMap(data);
      }
    });
  }

  Stream<List<Doctor>> loadDoctors(String specialisation) {
    Query query = _firestore
        .collection('users')
        .where('type', isEqualTo: 'Doctor');

    if (specialisation.isNotEmpty) {
      query = query.where('specialisation', isEqualTo: specialisation);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Doctor.fromMap(data);
      }).toList();
    });
  }
}

@riverpod
UsersRepository usersRepository(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return UsersRepository(firestore);
}

@riverpod
Stream<AppUser> loadUserInformation(Ref ref, String userId) {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.loadUserInformation(userId);
}

@riverpod
Stream<List<Doctor>> loadDoctors(Ref ref, String specialisation) {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.loadDoctors(specialisation);
}
