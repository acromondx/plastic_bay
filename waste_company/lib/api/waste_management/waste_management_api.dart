import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/api/waste_management/waste_management_interface.dart';
import 'package:waste_company/model/plastic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/api_failure.dart';

class WasteManagementAPI implements WasteManagementInterface {
  final FirebaseFirestore _firestore;
  WasteManagementAPI({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<List<Plastic>> getPlasticPost(
      {required GeoPoint currentLocation}) async {
    final plasticCollection = await _firestore.collection('plastic_post').get();
    return plasticCollection.docs
        .map((e) => Plastic.fromMap(e.data()))
        .toList();
  }

  @override
  FutureVoid updatePost({required Plastic plastic}) async {
    try {
      final updateDocument = await _firestore
          .collection('plastic_post')
          .doc(plastic.plasticId)
          .update(plastic.toMap());
      return right(updateDocument);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
