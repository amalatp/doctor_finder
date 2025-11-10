import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorItemWidget extends ConsumerWidget {
  const DoctorItemWidget({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
