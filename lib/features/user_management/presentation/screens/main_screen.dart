import 'package:doctor_finder/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:doctor_finder/features/chat/presentation/screens/chat_screen.dart';
import 'package:doctor_finder/features/user_management/presentation/provider/current_tab_provider.dart';
import 'package:doctor_finder/features/user_management/presentation/screens/doctor_screen.dart';
import 'package:doctor_finder/features/user_management/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabNotifierProvider);
    _tabController.index = currentIndex;

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeScreen(),
          DoctorScreen(),
          BookingsScreen(),
          ChatScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(currentTabNotifierProvider.notifier).setTab(value);
        },
        iconSize: 20,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined),
            label: 'Doctors',
            activeIcon: Icon(Icons.person_pin),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
