import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      debugShowCheckedModeBanner: false,
      title: 'Doctor Finder App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: AppStyles.mainColor,
          iconTheme: IconThemeData().copyWith(color: Colors.white, size: 30),
        ),
        fontFamily: 'Madimi One',
        useMaterial3: true,
      ),
    );
  }
}
