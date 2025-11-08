import 'package:doctor_finder/common_widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widgets/common_button.dart';
import 'package:doctor_finder/common_widgets/common_container.dart';
import 'package:doctor_finder/features/authentication/presentation/controller/auth_controller.dart';
import 'package:doctor_finder/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
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
                    'assets/images/doctor_logo.png',
                    height: SizeCofig.getProportionateHeight(100),
                  ),
                  Text(
                    "Sign In to Your Account",
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'Enter you email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                    textInputType: TextInputType.text,
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  CommonButton(
                    isLoading: state.isLoading,
                    onTap: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;
                      ref
                          .read(authControllerProvider.notifier)
                          .signInWithEmailAndPassword(email, password);
                    },
                    title: 'Sign In',
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'OR',
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CommonContainer(
                    text: 'Register as a User',
                    onTap: () {
                      context.goNamed(AppRoutes.userRegister.name);
                    },
                  ),
                  const SizedBox(height: 10),
                  CommonContainer(
                    text: 'Register as a Doctor',
                    onTap: () {
                      context.goNamed(AppRoutes.doctorRegister.name);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
