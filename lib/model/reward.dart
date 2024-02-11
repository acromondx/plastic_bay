// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class Reward {
 final String rewardId;
 final String name;
 final String description;
 final double value;
 final int quantity;
 final String category;
  Reward({
    required this.rewardId,
    required this.name,
    required this.description,
    required this.value,
    required this.quantity,
    required this.category,
  });
 

  Reward copyWith({
    String? rewardId,
    String? name,
    String? description,
    double? value,
    int? quantity,
    String? category,
  }) {
    return Reward(
      rewardId: rewardId ?? this.rewardId,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rewardId': rewardId,
      'name': name,
      'description': description,
      'value': value,
      'quantity': quantity,
      'category': category,
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      rewardId: map['rewardId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      value: map['value'] as double,
      quantity: map['quantity'] as int,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Reward(rewardId: $rewardId, name: $name, description: $description, value: $value, quantity: $quantity, category: $category)';
  }

  @override
  bool operator ==(covariant Reward other) {
    if (identical(this, other)) return true;
  
    return 
      other.rewardId == rewardId &&
      other.name == name &&
      other.description == description &&
      other.value == value &&
      other.quantity == quantity &&
      other.category == category;
  }

  @override
  int get hashCode {
    return rewardId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      value.hashCode ^
      quantity.hashCode ^
      category.hashCode;
  }
}
