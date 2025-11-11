import 'package:doctor_finder/common_widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/features/user_management/presentation/provider/current_tab_provider.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_item_widget.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NearbyDoctorsWidget extends ConsumerWidget {
  const NearbyDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(loadDoctorsProvider(''), (_, state) {
      state.showAlertDialogOnError(context);
    });

    final listOfDoctorsAsyncValue = ref.watch(loadDoctorsProvider(''));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nearby Doctors",
                style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(currentTabNotifierProvider.notifier).setTab(1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.mainColor,
                ),
                child: Text("View All", style: AppStyles.normalTextStyle),
              ),
            ],
          ),
          SizedBox(
            height: SizeCofig.getProportionateHeight(200),
            child: AsyncValueWidget<List<Doctor>>(
              value: listOfDoctorsAsyncValue,
              data: (doctors) {
                return doctors.isEmpty
                    ? Center(child: Text("No doctors found"))
                    : ListView.builder(
                        itemCount: doctors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DoctorItemWidget(doctor: doctor),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
