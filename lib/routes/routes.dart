import 'package:doctor_finder/features/authentication/domain/doctor.dart';
import 'package:doctor_finder/features/authentication/presentation/screens/doctor_register.dart';
import 'package:doctor_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:doctor_finder/features/authentication/presentation/screens/user_register.dart';
import 'package:doctor_finder/features/splash_and_onboarding/presentation/onboarding_screen.dart';
import 'package:doctor_finder/features/splash_and_onboarding/presentation/splash_screen.dart';
import 'package:doctor_finder/features/user_management/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_finder/features/user_management/presentation/screens/main_screen.dart';
import 'package:doctor_finder/routes/go_router_refresh_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

enum AppRoutes {
  splash,
  onboarding,
  signIn,
  doctorRegister,
  userRegister,
  main,
  doctorDetails,
}

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

@riverpod
GoRouter goRouter(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn &&
          (state.uri.toString() == '/signIn' ||
              state.uri.toString() == '/userRegister' ||
              state.uri.toString() == '/doctorRegister')) {
        return '/main';
      }
      if (!isLoggedIn && state.uri.toString() == '/main') {
        return '/signIn';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
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
      GoRoute(
        path: '/doctorRegister',
        name: AppRoutes.doctorRegister.name,
        builder: (context, state) => const DoctorRegister(),
      ),
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/doctorDetails',
        name: AppRoutes.doctorDetails.name,
        builder: (context, state) {
          final doctor = state.extra as Doctor;
          return DoctorDetailsScreen(doctor: doctor);
        },
      ),
    ],
  );
}
