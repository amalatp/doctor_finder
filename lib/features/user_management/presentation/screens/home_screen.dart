import 'dart:developer';

import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/bookings/data/booking_repository.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';
import 'package:doctor_finder/features/bookings/presentation/widgets/upcoming_booking_widget.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_item_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_speciality_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/nearby_doctors_widget.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsyncValue = ref.watch(loadUserInformationProvider(userId));
    final bookingsAsync = ref.watch(loadUserBookingsProvider(userId));

    DateTime parseBookingDateTime(String date, String time) {
      final formattedDate = DateFormat("dd-MM-yyyy").parse(date);
      final formattedTime = DateFormat.Hm().parse(time);

      return DateTime(
        formattedDate.year,
        formattedDate.month,
        formattedDate.day,
        formattedTime.hour,
        formattedTime.minute,
      );
    }

    Booking? getSoonestUpcomingBooking(List<Booking> bookings) {
      final now = DateTime.now();

      Booking? soonest;

      for (var booking in bookings) {
        try {
          log("Checking booking: $booking");
          DateTime bookingDateTime = parseBookingDateTime(
            booking.date,
            booking.time,
          );
          log('Parsed booking date and time: $bookingDateTime');
          if (bookingDateTime.isBefore(now)) continue;
          if (soonest == null ||
              bookingDateTime.isAfter(
                parseBookingDateTime(soonest.date, soonest.time),
              )) {
            log("keri");
            soonest = booking;
          }
        } catch (e) {
          log("Error parsing booking date/time: $e");
          continue;
        }
      }
      log("Soonest Booking: $soonest");
      return soonest;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Finder App', style: AppStyles.titleTextStyle),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: AsyncValueWidget<AppUser>(
                value: userDataAsyncValue,
                data: (usrData) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(usrData.imageUrl),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Your Upcoming Bookings",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
              ),
              AsyncValueWidget(
                value: bookingsAsync,
                data: (bookings) {
                  final soonestBooking = getSoonestUpcomingBooking(bookings);
                  if (soonestBooking != null) {
                    final doctorDataAsync = ref.watch(
                      loadUserInformationProvider(soonestBooking.doctorId),
                    );
                    return AsyncValueWidget<AppUser>(
                      value: doctorDataAsync,
                      data: (doctorData) {
                        return UpComingBookingWidget(
                          date: soonestBooking.date,
                          time: soonestBooking.time,
                          specialization: 'Service: ${soonestBooking.service}',
                          onTap: () {},
                          imageUrl: doctorData.imageUrl,
                          name: doctorData.name,
                          icon: Icons.call,
                        );
                      },
                    );
                  } else {
                    return Container(
                      width: SizeCofig.screenWidth * 0.9,
                      height: SizeCofig.getProportionateHeight(100),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "No upcoming bookings",
                        style: AppStyles.normalTextStyle,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: SizeCofig.getProportionateHeight(15)),
              DoctorSpecialityWidget(),
              SizedBox(height: SizeCofig.getProportionateHeight(15)),
              NearbyDoctorsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
