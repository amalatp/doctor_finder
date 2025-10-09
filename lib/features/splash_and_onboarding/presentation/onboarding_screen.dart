import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to Our App',
      'description': 'Discover Doctors Near You',
      'image': 'assets/images/doctor_logo.png',
    },
    {
      'title': 'Connect With Doctors',
      'description': 'Book Appointment With a Doctor',
      'image': 'assets/images/doctor_logo.png',
    },
    {
      'title': 'Get Started',
      'description': 'Sign In to Countinue',
      'image': 'assets/images/doctor_logo.png',
    },
  ];

  void _onPagechanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _skip() {
    _completeOnbarding();
  }

  Future<void> _completeOnbarding() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('hasSeenOnboarding', true);
    context.goNamed(AppRoutes.signIn.name);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onPagechanged,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(_pages[index]['image']!, height: 250),
                    const SizedBox(height: 20),
                    Text(
                      _pages[index]['title']!,
                      style: AppStyles.headingTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        _pages[index]['description']!,
                        style: AppStyles.titleTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: 20,
              right: 20,
              child: _currentIndex < _pages.length - 1
                  ? GestureDetector(
                      child: Text(
                        'Skip',
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: _currentIndex == index ? 12 : 8,
                    width: _currentIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppStyles.mainColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            if (_currentIndex == _pages.length - 1)
              Positioned(
                bottom: 40,
                left: 30,
                right: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _completeOnbarding,
                  child: Text('Login to App', style: AppStyles.titleTextStyle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
