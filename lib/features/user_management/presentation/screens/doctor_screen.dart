import 'package:doctor_finder/common_widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widgets/async_value_widget.dart';
import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/user_management/data/users_repository.dart';
import 'package:doctor_finder/features/user_management/presentation/provider/specialisation_prvider.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_list_tile_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/search_bar_widget.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/speciality_list_in_doctors_screen.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorScreen extends ConsumerWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialization = ref.watch(specialisationNotifierProvider);
    final doctorsAsyncValue = ref.watch(loadDoctorsProvider(specialization));

    ref.listen<AsyncValue>(loadDoctorsProvider(specialization), (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors in the App', style: AppStyles.titleTextStyle),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeCofig.getProportionateHeight(10)),
          Row(
            children: [
              Expanded(flex: 3, child: SearchBarWidget()),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.mainColor,
                  ),
                  onPressed: () {
                    ref
                        .read(specialisationNotifierProvider.notifier)
                        .setSpecialisation('');
                  },
                  child: Text(
                    "Show All",
                    style: AppStyles.normalTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeCofig.getProportionateHeight(10)),
          SpecialityListInDoctorsScreen(),

          SizedBox(height: SizeCofig.getProportionateHeight(10)),
          Expanded(
            child: AsyncValueWidget<List<Doctor>>(
              value: doctorsAsyncValue,
              data: (doctors) {
                return doctors.isEmpty
                    ? Center(
                        child: Text(
                          'No doctors found.',
                          style: AppStyles.normalTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return DoctorListTileWidget(doctor: doctor);
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
