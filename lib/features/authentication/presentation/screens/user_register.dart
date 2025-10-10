import 'dart:io';

import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(10, 10, 100, 0),
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
                              'assets/images/doctor-placeholder.jpg',
                            ),
                      radius: SizeCofig.getProportionateHeight(60),
                    ),
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
