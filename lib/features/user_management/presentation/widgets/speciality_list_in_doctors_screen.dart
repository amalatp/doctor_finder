import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:doctor_finder/utils/specialisation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecialityListInDoctorsScreen extends ConsumerWidget {
  const SpecialityListInDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfSpecialisation = ref.watch(specialisationListProvider);
    return SizedBox(
      height: SizeCofig.getProportionateHeight(60),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfSpecialisation.length,
        itemBuilder: (context, index) {
          final speciality = listOfSpecialisation[index];
          final Map<String, IconData> specialityIcons = {
            'Eyes': Icons.remove_red_eye,
            'ENT': Icons.hearing,
            'Teeth': Icons.mood_outlined,
            'Skin': Icons.face,
            'Limbs': Icons.run_circle,
          };
          final icon = specialityIcons[speciality];
          return InkWell(
            onTap: () {
              // Handle speciality tap
            },
            child: Container(
              height: SizeCofig.getProportionateHeight(60),
              width: SizeCofig.getProportionateHeight(60),
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppStyles.mainColor.withOpacity(0.2),
              ),
              child: Icon(icon, color: AppStyles.mainColor, size: 40),
            ),
          );
        },
      ),
    );
  }
}
