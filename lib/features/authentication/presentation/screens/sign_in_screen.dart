import 'package:doctor_finder/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assest/images/doctor_logo.png',
                  height: SizeCofig.getProportionateHeight(100),
                ),
                Text(
                  "Sign In to Your Account",
                  style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 15),
                CommonTextField(
                  controller: _emailController,
                  hintText: 'Enter you email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: _passwordController,
                  hintText: 'Enter password',
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
