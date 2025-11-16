import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/bookings/data/booking_repository.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';
import 'package:doctor_finder/features/bookings/presentation/widgets/upcoming_booking_widget.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UpComingBookingsScreen extends ConsumerStatefulWidget {
  const UpComingBookingsScreen({super.key});

  @override
  ConsumerState<UpComingBookingsScreen> createState() =>
      _UpComingBookingsScreenState();
}

class _UpComingBookingsScreenState
    extends ConsumerState<UpComingBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userAsyncValue = ref.watch(loadUserInformationProvider(userId));
    final bookingAsyncValue = ref.watch(loadUserBookingsProvider(userId));

    List<Booking> getUpcomingBookings(List<Booking> bookings) {
      DateTime today = DateTime.now();
      DateTime todayOnly = DateTime(today.year, today.month, today.day);

      return bookings.where((booking) {
        DateTime bookingDate = DateFormat("dd-MM-yyyy").parse(booking.date);
        return bookingDate.isAfter(todayOnly) ||
            bookingDate.isAtSameMomentAs(todayOnly);
      }).toList();
    }

    return Scaffold(
      body: AsyncValueWidget<AppUser>(
        value: userAsyncValue,
        data: (userData) {
          if (userData.type == 'Doctor') {
            final doctorBookingsAsyncValue = ref.watch(
              loadDoctorBookingsProvider(userData.userId),
            );

            return AsyncValueWidget<List<Booking>>(
              value: doctorBookingsAsyncValue,
              data: (doctorBookings) {
                final upcomingBookings = getUpcomingBookings(doctorBookings);
                return upcomingBookings.isEmpty
                    ? Center(child: Text('No Bookings yet'))
                    : ListView.builder(
                        itemCount: upcomingBookings.length,
                        itemBuilder: (context, index) {
                          final booking = upcomingBookings[index];
                          final userDataAsync = ref.watch(
                            loadUserInformationProvider(booking.userId),
                          );
                          return AsyncValueWidget<AppUser>(
                            value: userDataAsync,
                            data: (userData) {
                              return UpComingBookingWidget(
                                onTap: () {},
                                date: booking.date,
                                time: booking.time,
                                specialization:
                                    'Specialization ${booking.service}',
                                imageUrl: userData.imageUrl,
                                name: userData.name,
                                icon: Icons.delete,
                              );
                            },
                          );
                        },
                      );
              },
            );
          } else {
            return AsyncValueWidget<List<Booking>>(
              value: bookingAsyncValue,
              data: (userBookings) {
                final upcomingBookings = getUpcomingBookings(userBookings);
                return upcomingBookings.isEmpty
                    ? Center(child: Text('No Bookings Yet'))
                    : ListView.builder(
                        itemCount: upcomingBookings.length,
                        itemBuilder: (context, index) {
                          final booking = upcomingBookings[index];
                          final doctorDataAsync = ref.watch(
                            loadUserInformationProvider(booking.doctorId),
                          );
                          return AsyncValueWidget<AppUser>(
                            value: doctorDataAsync,
                            data: (doctorData) {
                              return UpComingBookingWidget(
                                onTap: () {},
                                date: booking.date,
                                time: booking.time,
                                specialization:
                                    'Specialization ${booking.service}',
                                imageUrl: doctorData.imageUrl,
                                name: doctorData.name,
                                icon: Icons.delete,
                              );
                            },
                          );
                        },
                      );
              },
            );
          }
        },
      ),
    );
  }
}
