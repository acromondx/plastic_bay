import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/api/waste_management/waste_management_interface.dart';
import 'package:waste_company/model/plastic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/api_failure.dart';

class WasteManagementAPI implements WasteManagementInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  WasteManagementAPI(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;
  @override
  Future<List<Plastic>> getPlasticPost() async {
    final plasticCollection = await _firestore
        .collection('plastic_post')
        .where('status', isNotEqualTo: 'accepted')
        .get();
    return plasticCollection.docs
        .map((e) => Plastic.fromMap(e.data()))
        .toList();
  }

  @override
  FutureVoid updatePost({
    required String plasticId,
    required Map<String, dynamic> updateFields,
  }) async {
    try {
      final updateDocument = await _firestore
          .collection('plastic_post')
          .doc(plasticId)
          .update(updateFields);
      return right(updateDocument);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<List<Plastic>> getPlasticPostByCompanyId(
      {required bool isCompleted}) async {
    final plasticCollection = await _firestore
        .collection('plastic_post')
        .where('acceptedCompanyId', isEqualTo: _auth.currentUser!.uid)
        .where('status', isEqualTo: isCompleted ? 'pickedUp' : 'accepted')
        .get();
    return plasticCollection.docs
        .map((e) => Plastic.fromMap(e.data()))
        .toList();
  }

  @override
  FutureVoid updateContributorsAnalytics({
    required String contributorsId,
    required Map<String, dynamic> updateFields,
  }) async {
    try {
      final updateDocument = await _firestore
          .collection('wasteContributors')
          .doc(contributorsId)
          .update(updateFields);
      return right(updateDocument);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
