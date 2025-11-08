import 'dart:io';

import 'package:doctor_finder/common_widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widgets/common_button.dart';
import 'package:doctor_finder/common_widgets/common_container.dart';
import 'package:doctor_finder/features/authentication/presentation/controller/auth_controller.dart';
import 'package:doctor_finder/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/keys.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:doctor_finder/utils/specialisation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';

class DoctorRegister extends ConsumerStatefulWidget {
  const DoctorRegister({super.key});

  @override
  ConsumerState<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends ConsumerState<DoctorRegister> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  File? _selectedImage;
  String? _selectedSpecialisation;

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
    _descriptionController.dispose();
    _yearsOfExperienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfSpecialisations = ref.watch(specialisationProvider);
    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
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
                    'Doctor Registration',
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
                  CommonTextField(
                    controller: _descriptionController,
                    hintText: 'Enter Description',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _yearsOfExperienceController,
                    hintText: 'Enter Years of Experience',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Select Specialisation',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // contentPadding: const EdgeInsets.symmetric(
                      //   horizontal: 10,
                      //   vertical: 5,
                      // ),
                    ),
                    initialValue: _selectedSpecialisation,
                    items: listOfSpecialisations
                        .map(
                          (specialisation) => DropdownMenuItem<String>(
                            value: specialisation,
                            child: Text(
                              specialisation,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecialisation = value;
                      });
                    },
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
                    isLoading: state.isLoading,
                    onTap: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;
                      final name = _nameController.text.trim();
                      final phoneNumber = _phoneNumberController.text.trim();
                      final location = _locationController.text.trim();
                      final description = _descriptionController.text.trim();
                      final yearsOfExperience = _yearsOfExperienceController
                          .text
                          .trim();
                      if (_selectedImage == null ||
                          _selectedSpecialisation == null ||
                          _latitude == null ||
                          _longitude == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please ensure image, specialisation and location are selected',
                            ),
                          ),
                        );
                        return;
                      }
                      ref
                          .read(authControllerProvider.notifier)
                          .createDoctorWithEmailAndPassword(
                            email: email,
                            password: password,
                            name: name,
                            phoneNumber: phoneNumber,
                            profileImage: _selectedImage!,
                            specialization: _selectedSpecialisation!,
                            location: location,
                            latitude: _latitude!,
                            longitude: _longitude!,
                            type: 'Doctor',
                            description: description,
                            yearsOfExperience:
                                int.tryParse(yearsOfExperience) ?? 0,
                          );
                    },
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
                    text: "Sign in to my account",
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
