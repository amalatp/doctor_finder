import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _specialisationList = [
  'Eyes',
  'ENT',
  'Teeth',
  'Skin',
  'Limbs',
];

final specialisationListProvider = Provider<List<String>>((ref) {
  return _specialisationList;
});
