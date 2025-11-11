import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/calculate_distance.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/rating_stars.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorItemWidget extends ConsumerWidget {
  const DoctorItemWidget({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsync = ref.watch(loadUserInformationProvider(userId));
    return AsyncValueWidget<AppUser>(
      value: userDataAsync,
      data: (userData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                doctor.imageUrl,
                height: SizeCofig.getProportionateHeight(100),
                width: SizeCofig.getProportionateWidth(180),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              doctor.name,
              style: AppStyles.normalTextStyle.copyWith(color: Colors.black),
            ),
            Text(doctor.specialization, style: TextStyle(fontSize: 14)),
            Row(
              children: [
                RatingStars(rating: doctor.ratings),
                SizedBox(width: 5),
                Text('(100)', style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.social_distance, size: 16),
                const SizedBox(width: 5),
                Text(
                  '${calculateDistance(mylat: userData.latitude, mylng: userData.longitude, doclat: doctor.latitude, doclng: doctor.longitude).toStringAsFixed(2)} km away',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
