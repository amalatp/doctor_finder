import 'dart:developer';

import 'package:doctor_finder/common_widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widgets/common_button.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/bookings/domain/booking.dart';
import 'package:doctor_finder/features/bookings/presentation/controller/booking_controller.dart';
import 'package:doctor_finder/features/chat/domain/conversation_args.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/rating_stars.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DoctorDetailsScreen extends ConsumerStatefulWidget {
  const DoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  ConsumerState<DoctorDetailsScreen> createState() =>
      _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends ConsumerState<DoctorDetailsScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String? get _formatedDate {
    if (_selectedDate == null) return null;
    return DateFormat('dd-MM-yyyy').format(_selectedDate!);
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day + 30),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String? get _formatedTime {
    if (_selectedTime == null) return null;
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> _pickTime() async {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(currentUserProvider)!.uid;
    final state = ref.watch(bookingControllerProvider);
    ref.listen<AsyncValue>(bookingControllerProvider, (_, state) {
      return state.showAlertDialogOnError(context);
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Book ${widget.doctor.name}",
            style: AppStyles.titleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.doctor.imageUrl,
                    height: SizeCofig.screenHeight * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  widget.doctor.name,
                  style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                Text(
                  "Specialization: ${widget.doctor.specialization}",
                  style: AppStyles.normalTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppStyles.mainColor,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.doctor.location,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingStars(rating: widget.doctor.ratings),
                        const SizedBox(width: 5),
                        Text(
                          widget.doctor.ratings.toStringAsFixed(1),
                          style: AppStyles.normalTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: SizeCofig.getProportionateHeight(40),
                      width: SizeCofig.screenWidth * 0.3,
                      decoration: BoxDecoration(
                        color: AppStyles.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.doctor.phoneNumber,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: SizeCofig.getProportionateHeight(40),
                        width: SizeCofig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: AppStyles.mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.pushNamed(
                                  AppRoutes.converstation.name,
                                  extra: ConversationArgs(
                                    currentUserId: currentUserId,
                                    recieverId: widget.doctor.userId,
                                    recieverName: widget.doctor.name,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Message",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.normalTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: SizeCofig.getProportionateHeight(100),
                      width: SizeCofig.screenWidth * 0.27,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            size: 50,
                            color: AppStyles.mainColor,
                          ),
                          Text("Patients", textAlign: TextAlign.center),
                          Text("${widget.doctor.numberOfPatients} +"),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeCofig.getProportionateHeight(100),
                      width: SizeCofig.screenWidth * 0.27,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timelapse,
                            size: 50,
                            color: AppStyles.mainColor,
                          ),
                          Text("Experience", textAlign: TextAlign.center),
                          Text("${widget.doctor.yearsOfExperience} +"),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeCofig.getProportionateHeight(100),
                      width: SizeCofig.screenWidth * 0.27,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.reviews,
                            size: 50,
                            color: AppStyles.mainColor,
                          ),
                          Text("Reviews", textAlign: TextAlign.center),
                          Text("300"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "About",
                  style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(widget.doctor.description, textAlign: TextAlign.justify),
                const SizedBox(height: 10),
                Text(
                  "Day",
                  style: AppStyles.normalTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: AppStyles.mainColor,
                      size: 60,
                    ),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        width: SizeCofig.screenWidth * 0.5,
                        height: SizeCofig.getProportionateHeight(40),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppStyles.mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedDate != null
                              ? _formatedDate!
                              : "Tap to select date",
                          style: AppStyles.normalTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppStyles.mainColor,
                      size: 60,
                    ),
                    GestureDetector(
                      onTap: _pickTime,
                      child: Container(
                        width: SizeCofig.screenWidth * 0.5,
                        height: SizeCofig.getProportionateHeight(40),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppStyles.mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedTime != null
                              ? _formatedTime!
                              : "Tap to select time",
                          style: AppStyles.normalTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CommonButton(
                  isLoading: state.isLoading,
                  onTap: () async {
                    if (_selectedDate == null || _selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select date and time"),
                        ),
                      );
                      return;
                    }
                    final myBooking = Booking(
                      userId: currentUserId,
                      doctorId: widget.doctor.userId,
                      date: _formatedDate!,
                      time: _formatedTime!,
                      service: widget.doctor.specialization,
                    );
                    final result = await ref
                        .read(bookingControllerProvider.notifier)
                        .saveBooking(booking: myBooking);
                    log("Booking result: $result");

                    if (result) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Appointment booked successfully",
                              style: TextStyle(fontSize: 20),
                            ),
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 120,
                            ),
                            alignment: Alignment.center,
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppStyles.mainColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Ok",
                                  style: AppStyles.normalTextStyle,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  title: 'Book Appointment',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
