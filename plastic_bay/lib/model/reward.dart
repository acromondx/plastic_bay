// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:isar/isar.dart';
part 'reward.g.dart';

@collection
class Reward {
  Id ? id = Isar.autoIncrement;
 final String rewardId;
 final String name;
 final String description;
 final double value;
 final int quantity;
 final String category;
 final String imageUrl;
  Reward({
    this.id,
    required this.rewardId,
    required this.name,
    required this.description,
    required this.value,
    required this.quantity,
    required this.category,
    required this.imageUrl,
  });
 

  Reward copyWith({
    String? rewardId,
    String? name,
    String? description,
    double? value,
    int? quantity,
    String? category,
    String? imageUrl,
    Id ? id
  }) {
    return Reward(
      rewardId: rewardId ?? this.rewardId,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
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
      'imageUrl': imageUrl,
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
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Reward(rewardId: $rewardId, name: $name, description: $description, value: $value, quantity: $quantity, category: $category, imageUrl: $imageUrl)';
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
      other.category == category &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return rewardId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      value.hashCode ^
      quantity.hashCode ^
      category.hashCode ^
      imageUrl.hashCode;
  }
}
