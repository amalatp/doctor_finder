import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_repository.g.dart';

class BookingRepository {
  BookingRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> saveBooking({required Booking booking}) async {
    final docRef = _firestore.collection('bookings').doc();
    final bookingWithId = booking.copyWith(id: docRef.id);
    await docRef.set(bookingWithId.toMap());
  }

  Stream<List<Booking>> loadUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Booking>> loadDoctorBookings(String doctorId) {
    return _firestore
        .collection('bookings')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList(),
        );
  }
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return BookingRepository(firestore);
}

@riverpod
Stream<List<Booking>> loadUserBookings(Ref ref, String userId) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.loadUserBookings(userId);
}

@riverpod
Stream<List<Booking>> loadDoctorBookings(Ref ref, String doctorId) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.loadDoctorBookings(doctorId);
}
