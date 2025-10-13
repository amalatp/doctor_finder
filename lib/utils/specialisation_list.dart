import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _specialisationList = [
  'Cardiologist',
  'Dermatologist',
  'Neurologist',
  'Pediatrician',
  'Psychiatrist',
  'Radiologist',
  'Oncologist',
  'Orthopedic Surgeon',
  'General Practitioner',
  'Gynecologist',
];

final specialisationProvider = Provider<List<String>>((ref) {
  return _specialisationList;
});
