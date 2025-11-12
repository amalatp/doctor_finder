import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/user_management/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorListTileWidget extends StatelessWidget {
  const DoctorListTileWidget({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(AppRoutes.doctorDetails.name, extra: doctor);
      },
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(doctor.imageUrl),
      ),
      title: Text(
        doctor.name,
        style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specialisation: ${doctor.specialization}"),
          Row(
            children: [
              Icon(Icons.location_on, size: 20, color: AppStyles.mainColor),
              Expanded(
                child: Text(
                  doctor.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: const Icon(
        Icons.directions,
        color: AppStyles.mainColor,
        size: 50,
      ),
    );
  }
}
