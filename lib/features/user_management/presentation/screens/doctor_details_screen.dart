import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/rating_stars.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorDetailsScreen extends ConsumerStatefulWidget {
  const DoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  ConsumerState<DoctorDetailsScreen> createState() =>
      _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends ConsumerState<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Book ${widget.doctor.name}",
            style: AppStyles.titleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.doctor.imageUrl,
                    height: SizeCofig.screenHeight * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  widget.doctor.name,
                  style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                Text(
                  "Specialization: ${widget.doctor.specialization}",
                  style: AppStyles.normalTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppStyles.mainColor,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.doctor.location,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingStars(rating: widget.doctor.ratings),
                        const SizedBox(width: 5),
                        Text(
                          widget.doctor.ratings.toStringAsFixed(1),
                          style: AppStyles.normalTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: SizeCofig.getProportionateHeight(40),
                      width: SizeCofig.screenWidth * 0.3,
                      decoration: BoxDecoration(
                        color: AppStyles.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.doctor.phoneNumber,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: SizeCofig.getProportionateHeight(40),
                        width: SizeCofig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: AppStyles.mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Message",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.normalTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
