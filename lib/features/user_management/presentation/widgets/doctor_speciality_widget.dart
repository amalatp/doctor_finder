import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:doctor_finder/utils/specialisation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorSpecialityWidget extends ConsumerWidget {
  const DoctorSpecialityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfSpecialisations = ref.watch(specialisationListProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Doctor Specialities",
                style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.mainColor,
                ),
                child: Text("See All", style: AppStyles.normalTextStyle),
              ),
            ],
          ),
          SizedBox(
            height: SizeCofig.getProportionateHeight(120),
            child: ListView.builder(
              itemCount: listOfSpecialisations.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final speciality = listOfSpecialisations[index];
                Map<String, IconData> specialityIcons = {
                  'Eyes': Icons.remove_red_eye,
                  'ENT': Icons.hearing,
                  'Teeth': Icons.mood_outlined,
                  'Skin': Icons.face,
                  'Limbs': Icons.run_circle,
                };
                final icon = specialityIcons[speciality];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: SizeCofig.getProportionateHeight(60),
                        width: SizeCofig.getProportionateHeight(60),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppStyles.mainColor.withValues(alpha: .2),
                        ),
                        child: Icon(icon, color: AppStyles.mainColor, size: 30),
                      ),
                      SizedBox(height: SizeCofig.getProportionateHeight(10)),
                      Text(
                        speciality,
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
