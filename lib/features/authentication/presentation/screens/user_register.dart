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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  double? _latitude;
  double? _longitude;

  final _places = places.FlutterGooglePlacesSdk(AppKeys.googlePlacesKey);
  List<places.AutocompletePrediction> _predictions = [];

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

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
    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
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
                  const Text(
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
                                )
                                as ImageProvider,
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

                  // ✅ Updated Location Input using flutter_google_places_sdk
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter your location',
                          hintStyle: AppStyles.normalTextStyle.copyWith(
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            setState(() {
                              _predictions = [];
                            });
                            return;
                          }

                          final result = await _places
                              .findAutocompletePredictions(value);
                          setState(() {
                            _predictions = result.predictions;
                          });
                        },
                      ),
                      if (_predictions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _predictions.length,
                            itemBuilder: (context, index) {
                              final p = _predictions[index];
                              return ListTile(
                                leading: const Icon(Icons.location_on),
                                title: Text(p.fullText ?? ''),
                                onTap: () async {
                                  final detail = await _places.fetchPlace(
                                    p.placeId,
                                    fields: [
                                      places.PlaceField.Location,
                                      places.PlaceField.Address,
                                      places.PlaceField.Name,
                                    ],
                                  );

                                  final lat = detail.place?.latLng?.lat;
                                  final lng = detail.place?.latLng?.lng;

                                  setState(() {
                                    _latitude = lat;
                                    _longitude = lng;
                                    _locationController.text = p.fullText ?? '';
                                    _predictions = [];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                    ],
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

                      if (_selectedImage == null ||
                          _latitude == null ||
                          _longitude == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please ensure image and location are selected',
                            ),
                          ),
                        );
                        return;
                      }

                      ref
                          .read(authControllerProvider.notifier)
                          .createAppUserWithEmailAndPassword(
                            email: email,
                            password: password,
                            name: name,
                            phoneNumber: phoneNumber,
                            profileImage: _selectedImage!,
                            type: 'User',
                            location: location,
                            latitude: _latitude!,
                            longitude: _longitude!,
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
