import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';

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
