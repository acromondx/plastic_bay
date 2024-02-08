// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Reward {
 final String rewardId;
  Reward({
    required this.rewardId,
  });
 

  Reward copyWith({
    String? rewardId,
  }) {
    return Reward(
      rewardId: rewardId ?? this.rewardId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rewardId': rewardId,
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      rewardId: map['rewardId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Reward(rewardId: $rewardId)';

  @override
  bool operator ==(covariant Reward other) {
    if (identical(this, other)) return true;
  
    return 
      other.rewardId == rewardId;
  }

  @override
  int get hashCode => rewardId.hashCode;
}
