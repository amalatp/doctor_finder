import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.title,
  });
  final VoidCallback onTap;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: SizeCofig.getProportionateHeight(50),
        width: SizeCofig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppStyles.mainColor,
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : Text(title, style: AppStyles.normalTextStyle),
      ),
    );
  }
}
