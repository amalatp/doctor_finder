import 'package:flutter_riverpod/legacy.dart';

class CurrentNofier extends StateNotifier<int> {
  CurrentNofier() : super(0);

  void setTab(int newValue) {
    state = newValue;
  }
}

final currentTabNotifierProvider = StateNotifierProvider<CurrentNofier, int>(
  (ref) => CurrentNofier(),
);
