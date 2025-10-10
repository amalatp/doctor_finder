import 'package:doctor_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:doctor_finder/features/authentication/presentation/screens/user_register.dart';
import 'package:doctor_finder/features/splash_and_onboarding/presentation/onboarding_screen.dart';
import 'package:doctor_finder/features/splash_and_onboarding/presentation/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

enum AppRoutes { splash, onboarding, signIn, doctorRegister, userRegister }

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.onboarding.name,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/userRegister',
        name: AppRoutes.userRegister.name,
        builder: (context, state) => const UserRegister(),
      ),
    ],
  );
}
