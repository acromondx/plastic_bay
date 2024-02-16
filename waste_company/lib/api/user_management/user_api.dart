import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/api/user_management/user_interface.dart';
import 'package:waste_company/model/waste_company.dart';

import '../core/api_failure.dart';

class UserManagementAPI implements UserManagementInterface {
  final FirebaseFirestore _firestore;
  UserManagementAPI({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<WasteCompany> getCredentials({required String wasteCompanyId}) async {
    final credentials =
        await _firestore.collection('wastecompany').doc(wasteCompanyId).get();
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
