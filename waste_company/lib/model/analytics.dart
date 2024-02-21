// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Analytics {
  final String id;
  final int acceptedPost;
  final int pendingPost;
  final int pickedUpPost;
  Analytics({
    required this.id,
    required this.acceptedPost,
    required this.pendingPost,
    required this.pickedUpPost,
  });

  Analytics copyWith({
    String? id,
    int? acceptedPost,
    int? pendingPost,
    int? pickedUpPost,
  }) {
    return Analytics(
      id: id ?? this.id,
      acceptedPost: acceptedPost ?? this.acceptedPost,
      pendingPost: pendingPost ?? this.pendingPost,
      pickedUpPost: pickedUpPost ?? this.pickedUpPost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'acceptedPost': acceptedPost,
      'pendingPost': pendingPost,
      'pickedUpPost': pickedUpPost,
    };
  }

  factory Analytics.fromMap(Map<String, dynamic> map) {
    return Analytics(
      id: map['id'] as String,
      acceptedPost: map['acceptedPost'] as int,
      pendingPost: map['pendingPost'] as int,
      pickedUpPost: map['pickedUpPost'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Analytics.fromJson(String source) => Analytics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Analytics(id: $id, acceptedPost: $acceptedPost, pendingPost: $pendingPost, pickedUpPost: $pickedUpPost)';
  }

  @override
  bool operator ==(covariant Analytics other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.acceptedPost == acceptedPost &&
      other.pendingPost == pendingPost &&
      other.pickedUpPost == pickedUpPost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      acceptedPost.hashCode ^
      pendingPost.hashCode ^
      pickedUpPost.hashCode;
  }
}
