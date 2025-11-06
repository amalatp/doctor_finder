import 'package:doctor_finder/features/authentication/domain/app_user.dart';

class Doctor extends AppUser {
  final String specialization;
  final String description;
  final int ratings;
  final int numberOfPatients;
  final int yearsOfExperience;

  Doctor({
    required super.email,
    required super.name,
    required super.phoneNumber,
    required super.imageUrl,
    required super.location,
    required super.latitude,
    required super.longitude,
    required super.userId,
    required super.type,
    required this.specialization,
    required this.description,
    this.ratings = 0,
    this.numberOfPatients = 0,
    required this.yearsOfExperience,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      imageUrl: map['imageUrl'] as String,
      location: map['location'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      userId: map['userId'] as String,
      type: map['type'] as String,
      specialization: map['specialization'] as String,
      description: map['description'] as String,
      ratings: map['ratings'] as int,
      numberOfPatients: map['numberOfPatients'] as int,
      yearsOfExperience: map['yearsOfExperience'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final data = super.toMap();
    data.addAll({
      'specialization': specialization,
      'description': description,
      'ratings': ratings,
      'numberOfPatients': numberOfPatients,
      'yearsOfExperience': yearsOfExperience,
    });
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doctor &&
          super == other &&
          specialization == other.specialization &&
          description == other.description &&
          ratings == other.ratings &&
          numberOfPatients == other.numberOfPatients &&
          yearsOfExperience == other.yearsOfExperience);

  @override
  int get hashCode =>
      super.hashCode ^
      specialization.hashCode ^
      description.hashCode ^
      ratings.hashCode ^
      numberOfPatients.hashCode ^
      yearsOfExperience.hashCode;

  @override
  String toString() {
    return 'Doctor(${super.toString()}, '
        'specialization: $specialization, '
        'description: $description, '
        'ratings: $ratings, '
        'numberOfPatients: $numberOfPatients, '
        'yearsOfExperience: $yearsOfExperience)';
  }
}
