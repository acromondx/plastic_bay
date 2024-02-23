// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Analytics {
  final String id;
  final int acceptedPost;
  final int pendingPost;
  final int pickedUpPost;
  final double pointsGiven;
  Analytics({
    required this.id,
    required this.acceptedPost,
    required this.pendingPost,
    required this.pickedUpPost,
    required this.pointsGiven,
  });

  Analytics copyWith({
    String? id,
    int? acceptedPost,
    int? pendingPost,
    int? pickedUpPost,
    double? pointsGiven,
  }) {
    return Analytics(
      id: id ?? this.id,
      acceptedPost: acceptedPost ?? this.acceptedPost,
      pendingPost: pendingPost ?? this.pendingPost,
      pickedUpPost: pickedUpPost ?? this.pickedUpPost,
      pointsGiven: pointsGiven ?? this.pointsGiven,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'acceptedPost': acceptedPost,
      'pendingPost': pendingPost,
      'pickedUpPost': pickedUpPost,
      'pointsGiven': pointsGiven,
    };
  }

  factory Analytics.fromMap(Map<String, dynamic> map) {
    return Analytics(
      id: map['id'] as String,
      acceptedPost: map['acceptedPost'] as int,
      pendingPost: map['pendingPost'] as int,
      pickedUpPost: map['pickedUpPost'] as int,
      pointsGiven: map['pointsGiven'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Analytics.fromJson(String source) => Analytics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Analytics(id: $id, acceptedPost: $acceptedPost, pendingPost: $pendingPost, pickedUpPost: $pickedUpPost, pointsGiven: $pointsGiven)';
  }

  @override
  bool operator ==(covariant Analytics other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.acceptedPost == acceptedPost &&
      other.pendingPost == pendingPost &&
      other.pickedUpPost == pickedUpPost &&
      other.pointsGiven == pointsGiven;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      acceptedPost.hashCode ^
      pendingPost.hashCode ^
      pickedUpPost.hashCode ^
      pointsGiven.hashCode;
  }
}
