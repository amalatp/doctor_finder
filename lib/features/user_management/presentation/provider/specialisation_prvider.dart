import 'package:flutter_riverpod/legacy.dart';

class SpecialisationNotifier extends StateNotifier<String> {
  SpecialisationNotifier() : super('');

  void setSpecialisation(String newSpecialisation) {
    state = newSpecialisation;
  }
}

final specialisationNotifierProvider =
    StateNotifierProvider<SpecialisationNotifier, String>(
      (ref) => SpecialisationNotifier(),
    );
