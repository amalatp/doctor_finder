// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chat {
  final String chatId;
  final String lastMessage;
  final String time;
  final List<String> userIds;
  Chat({
    required this.chatId,
    required this.lastMessage,
    required this.time,
    required this.userIds,
  });

  Chat copyWith({
    String? chatId,
    String? lastMessage,
    String? time,
    List<String>? userIds,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      userIds: userIds ?? this.userIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'lastMessage': lastMessage,
      'time': time,
      'userIds': userIds,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String,
      lastMessage: map['lastMessage'] as String,
      time: map['time'] as String,
      userIds: List<String>.from((map['userIds'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(chatId: $chatId, lastMessage: $lastMessage, time: $time, userIds: $userIds)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.lastMessage == lastMessage &&
        other.time == time &&
        listEquals(other.userIds, userIds);
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        lastMessage.hashCode ^
        time.hashCode ^
        userIds.hashCode;
  }
}
