// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Booking {
  final String id;
  final String doctorId;
  final String userId;
  final String date;
  final String time;
  final String service;
  Booking({
    this.id = '',
    required this.doctorId,
    required this.userId,
    required this.date,
    required this.time,
    required this.service,
  });

  Booking copyWith({
    String? id,
    String? doctorId,
    String? userId,
    String? date,
    String? time,
    String? service,
  }) {
    return Booking(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      time: time ?? this.time,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorId': doctorId,
      'userId': userId,
      'date': date,
      'time': time,
      'service': service,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      doctorId: map['doctorId'] as String,
      userId: map['userId'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      service: map['service'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(id: $id, doctorId: $doctorId, userId: $userId, date: $date, time: $time, service: $service)';
  }

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.doctorId == doctorId &&
        other.userId == userId &&
        other.date == date &&
        other.time == time &&
        other.service == service;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorId.hashCode ^
        userId.hashCode ^
        date.hashCode ^
        time.hashCode ^
        service.hashCode;
  }
}
