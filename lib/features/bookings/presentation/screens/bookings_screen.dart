import 'package:doctor_finder/features/bookings/presentation/screens/past_bookings.dart';
import 'package:doctor_finder/features/bookings/presentation/screens/up_coming_bookings.dart';
import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final List<String> categories = ['Upcoming Bookings', 'Past Bookings'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = _selectedIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings', style: AppStyles.titleTextStyle),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppStyles.mainColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [UpComingBookingsScreen(), PastBookingsScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
