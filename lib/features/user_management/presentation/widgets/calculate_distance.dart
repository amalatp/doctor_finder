import 'package:geolocator/geolocator.dart';

double calculateDistance({
  required double mylat,
  required double mylng,
  required double doclat,
  required double doclng,
}) {
  final distance = Geolocator.distanceBetween(mylat, mylng, doclat, doclng);
  return distance / 1000;
}
