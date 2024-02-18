// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'package:plastic_bay/utils/enums/plastic_type.dart';

import '../utils/enums/post_status.dart';

class Plastic {
  final DateTime postedAt;
  final String pickUpDate;
  final String pickUpTime;
  final GeoPoint location;
  final PlasticStatus status;
  final PlasticType plasticType;
  final String contributorId;
  final String plasticId;
  final String description;
  final double quantity;
  final List<String> imageUrl;
  Plastic({
    required this.postedAt,
    required this.pickUpDate,
    required this.pickUpTime,
    required this.location,
    required this.status,
    required this.plasticType,
    required this.contributorId,
    required this.plasticId,
    required this.description,
    required this.quantity,
    required this.imageUrl,
  });

  Plastic copyWith({
    DateTime? postedAt,
    String? pickUpDate,
    String? pickUpTime,
    GeoPoint? location,
    PlasticStatus? status,
    PlasticType? plasticType,
    String? contributorId,
    String? plasticId,
    String? description,
    double? quantity,
    List<String>? imageUrl,
  }) {
    return Plastic(
      postedAt: postedAt ?? this.postedAt,
      pickUpDate: pickUpDate ?? this.pickUpDate,
      pickUpTime: pickUpTime ?? this.pickUpTime,
      location: location ?? this.location,
      status: status ?? this.status,
      plasticType: plasticType ?? this.plasticType,
      contributorId: contributorId ?? this.contributorId,
      plasticId: plasticId ?? this.plasticId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postedAt': postedAt.millisecondsSinceEpoch,
      'pickUpDate': pickUpDate,
      'pickUpTime': pickUpTime,
      'location': location,
      'status': status.name,
      'plasticType': plasticType.name,
      'contributorId': contributorId,
      'plasticId': plasticId,
      'description': description,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory Plastic.fromMap(Map<String, dynamic> map) {
    return Plastic(
      postedAt: DateTime.fromMillisecondsSinceEpoch(map['postedAt'] as int),
      pickUpDate: map['pickUpDate'] as String,
      pickUpTime: map['pickUpTime'] as String,
      location: (map['location'] as GeoPoint),
      status: plasticFromStringToStatus(map['status']),
      plasticType: plasticFromStringToType(map['plasticType']),
      contributorId: map['contributorId'] as String,
      plasticId: map['plasticId'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as double,
      imageUrl: List<String>.from((map['imageUrl'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Plastic.fromJson(String source) =>
      Plastic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plastic(postedAt: $postedAt, pickUpDate: $pickUpDate, pickUpTime: $pickUpTime, location: $location, status: $status, plasticType: $plasticType, contributorId: $contributorId, plasticId: $plasticId, description: $description, quantity: $quantity, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant Plastic other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.postedAt == postedAt &&
      other.pickUpDate == pickUpDate &&
      other.pickUpTime == pickUpTime &&
      other.location == location &&
      other.status == status &&
      other.plasticType == plasticType &&
      other.contributorId == contributorId &&
      other.plasticId == plasticId &&
      other.description == description &&
      other.quantity == quantity &&
      listEquals(other.imageUrl, imageUrl);
  }

  @override
  int get hashCode {
    return postedAt.hashCode ^
      pickUpDate.hashCode ^
      pickUpTime.hashCode ^
      location.hashCode ^
      status.hashCode ^
      plasticType.hashCode ^
      contributorId.hashCode ^
      plasticId.hashCode ^
      description.hashCode ^
      quantity.hashCode ^
      imageUrl.hashCode;
  }
}
