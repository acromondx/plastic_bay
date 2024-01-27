// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/enums/post_status.dart';

class PlasticPost {
  final Timestamp postAt;
  final GeoPoint location;
  final PostStatus status;
  final String contributorId;
  final String postId;
  final String description;
  PlasticPost({
    required this.postAt,
    required this.location,
    required this.status,
    required this.contributorId,
    required this.postId,
    required this.description,
  });

  PlasticPost copyWith({
    Timestamp? postAt,
    GeoPoint? location,
    PostStatus? status,
    String? contributorId,
    String? postId,
    String? description,
  }) {
    return PlasticPost(
      postAt: postAt ?? this.postAt,
      location: location ?? this.location,
      status: status ?? this.status,
      contributorId: contributorId ?? this.contributorId,
      postId: postId ?? this.postId,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postAt': postAt,
      'location': location,
      'status': status.name,
      'contributorId': contributorId,
      'postId': postId,
      'description': description,
    };
  }

  factory PlasticPost.fromMap(Map<String, dynamic> map) {
    return PlasticPost(
      postAt: (map['postAt'] as Timestamp),
      location: (map['location'] as GeoPoint),
      status: fromStringToStatus(map['status']),
      contributorId: map['contributorId'] as String,
      postId: map['postId'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlasticPost.fromJson(String source) =>
      PlasticPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlasticPost(postAt: $postAt, location: $location, status: $status, contributorId: $contributorId, postId: $postId, description: $description)';
  }

  @override
  bool operator ==(covariant PlasticPost other) {
    if (identical(this, other)) return true;

    return other.postAt == postAt &&
        other.location == location &&
        other.status == status &&
        other.contributorId == contributorId &&
        other.postId == postId &&
        other.description == description;
  }

  @override
  int get hashCode {
    return postAt.hashCode ^
        location.hashCode ^
        status.hashCode ^
        contributorId.hashCode ^
        postId.hashCode ^
        description.hashCode;
  }
}
