import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpComingBookingWidget extends ConsumerWidget {
  const UpComingBookingWidget({
    super.key,
    required this.date,
    required this.time,
    required this.specialization,
    required this.onTap,
    required this.imageUrl,
    required this.name,
    required this.icon,
  });
  final String date;
  final String time;
  final String specialization;
  final VoidCallback onTap;
  final String imageUrl;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: SizeCofig.getProportionateHeight(30)),
      width: SizeCofig.screenWidth,
      decoration: BoxDecoration(
        color: AppStyles.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: ClipOval(
              child: Image.network(
                imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(name, style: AppStyles.normalTextStyle),
            subtitle: Text(specialization, style: AppStyles.normalTextStyle),
            trailing: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onTap,
                icon: Icon(icon, color: AppStyles.mainColor, size: 30),
              ),
            ),
          ),
          SizedBox(height: SizeCofig.getProportionateHeight(10)),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.calendar_month,
                      size: 25,
                      color: Colors.white,
                    ),
                    title: Text(
                      date,
                      style: AppStyles.normalTextStyle.copyWith(
                        fontSize: SizeCofig.getProportionateHeight(12),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.white,
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.watch_later_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                    title: Text(
                      time,
                      style: AppStyles.normalTextStyle.copyWith(
                        fontSize: SizeCofig.getProportionateHeight(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
