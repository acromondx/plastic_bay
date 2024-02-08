// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class WasteContributor {
  final String id;
  final String name;
  final String email;
  final String notificationToken;
  final GeoPoint contributorLocation;
  final Timestamp joinedAt;
  final String pictureUrl;
  final int totalPost;
  final int rewardEarned;
  WasteContributor({
    required this.id,
    required this.name,
    required this.email,
    required this.notificationToken,
    required this.contributorLocation,
    required this.joinedAt,
    required this.pictureUrl,
    required this.totalPost,
    required this.rewardEarned,
  });

  WasteContributor copyWith({
    String? id,
    String? name,
    String? email,
    String? notificationToken,
    GeoPoint? contributorLocation,
    Timestamp? joinedAt,
    String? pictureUrl,
    int? totalPost,
    int? rewardEarned,
  }) {
    return WasteContributor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      notificationToken: notificationToken ?? this.notificationToken,
      contributorLocation: contributorLocation ?? this.contributorLocation,
      joinedAt: joinedAt ?? this.joinedAt,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      totalPost: totalPost ?? this.totalPost,
      rewardEarned: rewardEarned ?? this.rewardEarned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'notificationToken': notificationToken,
      'contributorLocation': contributorLocation,
      'joinedAt': joinedAt.millisecondsSinceEpoch,
      'pictureUrl': pictureUrl,
      'totalPost': totalPost,
      'rewardEarned': rewardEarned,
    };
  }

  factory WasteContributor.fromMap(Map<String, dynamic> map) {
    return WasteContributor(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      notificationToken: map['notificationToken'] as String,
      contributorLocation: (map['contributorLocation'] as GeoPoint),
      joinedAt: (map['joinedAt'] as Timestamp),
      pictureUrl: map['pictureUrl'] as String,
      totalPost: map['totalPost'] as int,
      rewardEarned: map['rewardEarned'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteContributor.fromJson(String source) =>
      WasteContributor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WasteContributor(id: $id, name: $name, email: $email, notificationToken: $notificationToken, contributorLocation: $contributorLocation, joinedAt: $joinedAt, pictureUrl: $pictureUrl, totalPost: $totalPost, rewardEarned: $rewardEarned)';
  }

  @override
  bool operator ==(covariant WasteContributor other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.notificationToken == notificationToken &&
      other.contributorLocation == contributorLocation &&
      other.joinedAt == joinedAt &&
      other.pictureUrl == pictureUrl &&
      other.totalPost == totalPost &&
      other.rewardEarned == rewardEarned;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      notificationToken.hashCode ^
      contributorLocation.hashCode ^
      joinedAt.hashCode ^
      pictureUrl.hashCode ^
      totalPost.hashCode ^
      rewardEarned.hashCode;
  }
}
