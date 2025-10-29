// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final String email;
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final String location;
  final double latitude;
  final double longitude;
  final String userId;
  final String type;
  AppUser({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.type,
  });

  AppUser copyWith({
    String? email,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    String? location,
    double? latitude,
    double? longitude,
    String? userId,
    String? type,
  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'type': type,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      imageUrl: map['imageUrl'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      userId: map['userId'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, phoneNumber: $phoneNumber, imageUrl: $imageUrl, location: $location, latitude: $latitude, longitude: $longitude, userId: $userId, type: $type)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.imageUrl == imageUrl &&
        other.location == location &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.userId == userId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        imageUrl.hashCode ^
        location.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        userId.hashCode ^
        type.hashCode;
  }
}
