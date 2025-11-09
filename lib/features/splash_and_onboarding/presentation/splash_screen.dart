import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _textAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final pref = await SharedPreferences.getInstance();
    final hasSeenOnboarding = pref.getBool('hasSeenOnboarding') ?? false;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (isLoggedIn) {
      context.goNamed(AppRoutes.main.name);
    } else if (hasSeenOnboarding) {
      context.goNamed(AppRoutes.signIn.name);
    } else {
      context.goNamed(AppRoutes.onboarding.name);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset('assets/images/doctor_logo.png', width: 150),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _textAnimation,
              child: Text(
                'Find Doctors Near You',
                style: AppStyles.titleTextStyle,
              ),
            ),
            SlideTransition(
              position: _textAnimation,
              child: Text(
                'No More Doctor Trouble',
                style: AppStyles.normalTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
