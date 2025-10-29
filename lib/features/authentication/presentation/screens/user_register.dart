import 'dart:io';

import 'package:doctor_finder/common_widgets/common_button.dart';
import 'package:doctor_finder/common_widgets/common_container.dart';
import 'package:doctor_finder/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/keys.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;

class UserRegister extends ConsumerStatefulWidget {
  const UserRegister({super.key});

  @override
  ConsumerState<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends ConsumerState<UserRegister> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _locationController = TextEditingController();
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  final _places = places.FlutterGooglePlacesSdk(AppKeys.googlePlacesKey);
  double? _latitude;
  double? _longitude;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(10, 10, 10, 0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/doctor_logo.png',
                    height: SizeCofig.getProportionateHeight(100),
                  ),
                  Text(
                    'User Registration',
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Divider(color: Colors.black, thickness: 2),
                  const SizedBox(height: 10),
                  Text(
                    'Tap to add profile photo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  GestureDetector(
                    onTap: _takePicture,
                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage(
                              'assets/images/doctor_placeholder.jpg',
                            ),
                      radius: SizeCofig.getProportionateHeight(60),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _nameController,
                    hintText: 'Enter Name',
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _phoneNumberController,
                    hintText: 'Enter Phone Number',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: _locationController,
                    googleAPIKey: AppKeys.googlePlacesKey,
                    debounceTime: 400,
                    isLatLngRequired: true,
                    inputDecoration: InputDecoration(
                      hintText: 'Enter your location',
                      hintStyle: AppStyles.normalTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    itemClick: (Prediction prediction) async {
                      setState(() {
                        _locationController.text = prediction.description ?? "";
                      });
                      final detail = await _places.fetchPlace(
                        prediction.placeId!,
                        fields: [
                          places.PlaceField.Location,
                          places.PlaceField.Name,
                          places.PlaceField.Address,
                        ],
                      );
                      _latitude = detail.place?.latLng?.lat;
                      _longitude = detail.place?.latLng?.lng;
                      _locationController
                          .selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length),
                      );
                    },
                    itemBuilder: (context, index, prediction) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 7),
                            Expanded(child: Text(prediction.description ?? '')),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'Enter Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                    isLoading: false,
                    onTap: () {},
                    title: 'Register',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "OR",
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  CommonContainer(
                    text: "sign in to my account",
                    onTap: () {
                      context.goNamed(AppRoutes.signIn.name);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
