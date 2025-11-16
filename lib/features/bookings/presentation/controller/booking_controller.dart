import 'package:doctor_finder/features/bookings/data/booking_repository.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'booking_controller.g.dart';

@riverpod
class BookingController extends _$BookingController {
  @override
  FutureOr<void> build() {}

  Future<bool> saveBooking({required Booking booking}) async {
    state = AsyncLoading();
    final bookingRepository = ref.read(bookingRepositoryProvider);
    state = await AsyncValue.guard(
      () => bookingRepository.saveBooking(booking: booking),
    );
    return state.hasError == false;
  }
}
