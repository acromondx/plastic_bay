import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/model/waste_contributor.dart';

import 'user_interface.dart';

class UserManagementAPI implements UserManagementInterface {
  final FirebaseFirestore _firestore;
  UserManagementAPI({required FirebaseFirestore firestore})
      : _firestore = firestore,
        super();
  @override
  FutureVoid saveContributorCredentials({
    required WasteContributor wasteContributor,
  }) async {
    try {
      final save = await _firestore
          .collection('wasteContributors')
          .doc(wasteContributor.id)
          .set(wasteContributor.toMap());
      return right(save);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<WasteContributor> contributorDetails({
    required String wasteContributorId,
  }) async {
    final details = await _firestore
        .collection('wasteContributors')
        .doc(wasteContributorId)
        .get();
    return WasteContributor.fromMap(details.data()!);
  }

  @override
  FutureVoid updateContributorDetails({
    required String wasteContributorId,
  }) async {
    try {
      final update = await _firestore
          .collection('wasteContributors')
          .doc(wasteContributorId)
          .update({});
      return right(update);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  FutureVoid spendPoint({
    required String wasteContributorId,
    required double totalSpending,
  }) async {
    try {
      final details = await _firestore
          .collection('wasteContributors')
          .doc(wasteContributorId)
          .get();
      WasteContributor wasteContributor =
          WasteContributor.fromMap(details.data()!);
      wasteContributor.copyWith(
          earnedPoint: wasteContributor.earnedPoint - totalSpending,
          pointsSpent: wasteContributor.pointsSpent + totalSpending);
      await _firestore
          .collection('wasteContributors')
          .doc(wasteContributorId)
          .update({
        'earnedPoint': wasteContributor.earnedPoint,
        'pointsSpent': wasteContributor.pointsSpent,
      });
      return right(null);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<List<WasteContributor>> topContributors() async {
    final contributors = await _firestore
        .collection('wasteContributors')
        .where(
          'totalPost',
          isGreaterThanOrEqualTo: 10,
        )
        .orderBy('totalPost', descending: true)
        .get();
    return contributors.docs
        .map((e) => WasteContributor.fromMap(e.data()))
        .toList();
  }
}
