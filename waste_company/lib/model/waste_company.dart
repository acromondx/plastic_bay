// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class WasteCompany {
  final String id;
  final String companyName;
  final String email;
  final int phoneNumber;
  final String logo;
  final GeoPoint location;
  final String notificationToken;
  WasteCompany({
    required this.id,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    required this.logo,
    required this.location,
    required this.notificationToken,
  });

  WasteCompany copyWith({
    String? id,
    String? companyName,
    String? email,
    int? phoneNumber,
    String? logo,
    GeoPoint? location,
    String? notificationToken,
  }) {
    return WasteCompany(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      logo: logo ?? this.logo,
      location: location ?? this.location,
      notificationToken: notificationToken ?? this.notificationToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'logo': logo,
      'location': location,
      'notificationToken': notificationToken,
    };
  }

  factory WasteCompany.fromMap(Map<String, dynamic> map) {
    return WasteCompany(
      id: map['id'] as String,
      companyName: map['companyName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as int,
      logo: map['logo'] as String,
      location: (map['location'] as GeoPoint),
      notificationToken: map['notificationToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteCompany.fromJson(String source) =>
      WasteCompany.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WasteCompany(id: $id, companyName: $companyName, email: $email, phoneNumber: $phoneNumber, logo: $logo, location: $location, notificationToken: $notificationToken)';
  }

  @override
  bool operator ==(covariant WasteCompany other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.logo == logo &&
        other.location == location &&
        other.notificationToken == notificationToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        logo.hashCode ^
        location.hashCode ^
        notificationToken.hashCode;
  }
}
