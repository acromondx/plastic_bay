import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/api/user_management/user_interface.dart';
import 'package:waste_company/model/waste_company.dart';

import '../core/api_failure.dart';

class UserManagementAPI implements UserManagementInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UserManagementAPI(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;
  @override
  Future<WasteCompany> getCredentials() async {
    final credentials =
        await _firestore.collection('wastecompany').doc(_auth.currentUser!.uid).get();
    return WasteCompany.fromMap(credentials.data()!);
  }

  @override
  FutureVoid saveCredentials({required WasteCompany wasteCompany}) async {
    try {
      final save = await _firestore
          .collection('wastecompany')
          .doc(wasteCompany.id)
          .set(wasteCompany.toMap());

      return right(save);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  FutureVoid updateCredentials({
    required String wasteCompanyId,
    required Map<String, dynamic> update,
  }) async {
    try {
      final updateDetails = await _firestore
          .collection('wastecompany')
          .doc(wasteCompanyId)
          .update(update);

      return right(updateDetails);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
