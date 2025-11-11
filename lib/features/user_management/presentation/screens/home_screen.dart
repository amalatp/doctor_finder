import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/app_user.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_item_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_speciality_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/nearby_doctors_widget.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsyncValue = ref.watch(loadUserInformationProvider(userId));
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
              Container(
                width: SizeCofig.screenWidth * 0.8,
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
