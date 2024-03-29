// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Analytics {
  final String id;
  final int acceptedPost;
  final int pendingPost;
  final int pickedUpPost;
  final double pointsGiven;
  final int cancelledPost;
  Analytics({
    required this.id,
    required this.acceptedPost,
    required this.pendingPost,
    required this.pickedUpPost,
    required this.pointsGiven,
    required this.cancelledPost,
  });

  Analytics copyWith({
    String? id,
    int? acceptedPost,
    int? pendingPost,
    int? pickedUpPost,
    double? pointsGiven,
    int? cancelledPost,
  }) {
    return Analytics(
      id: id ?? this.id,
      acceptedPost: acceptedPost ?? this.acceptedPost,
      pendingPost: pendingPost ?? this.pendingPost,
      pickedUpPost: pickedUpPost ?? this.pickedUpPost,
      pointsGiven: pointsGiven ?? this.pointsGiven,
      cancelledPost: cancelledPost ?? this.cancelledPost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'acceptedPost': acceptedPost,
      'pendingPost': pendingPost,
      'pickedUpPost': pickedUpPost,
      'pointsGiven': pointsGiven,
      'cancelledPost': cancelledPost,
    };
  }

  factory Analytics.fromMap(Map<String, dynamic> map) {
    return Analytics(
      id: map['id'] as String,
      acceptedPost: map['acceptedPost'] as int,
      pendingPost: map['pendingPost'] as int,
      pickedUpPost: map['pickedUpPost'] as int,
      pointsGiven: map['pointsGiven'] as double,
      cancelledPost: map['cancelledPost'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Analytics.fromJson(String source) => Analytics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Analytics(id: $id, acceptedPost: $acceptedPost, pendingPost: $pendingPost, pickedUpPost: $pickedUpPost, pointsGiven: $pointsGiven, cancelledPost: $cancelledPost)';
  }

  @override
  bool operator ==(covariant Analytics other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.acceptedPost == acceptedPost &&
      other.pendingPost == pendingPost &&
      other.pickedUpPost == pickedUpPost &&
      other.pointsGiven == pointsGiven &&
      other.cancelledPost == cancelledPost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      acceptedPost.hashCode ^
      pendingPost.hashCode ^
      pickedUpPost.hashCode ^
      pointsGiven.hashCode ^
      cancelledPost.hashCode;
  }
}
