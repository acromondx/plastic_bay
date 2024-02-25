import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/analytics/analytics_interface.dart';
import 'package:waste_company/api/core/api_failure.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/model/analytics.dart';

class AnalyticsApi implements AnalyticsInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AnalyticsApi(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;
  @override
  Future<Analytics> getAnalytics() async {
    final analytics = await _firestore
        .collection('analytics')
        .doc(_auth.currentUser!.uid)
        .get();
    return Analytics.fromMap(analytics.data()!);
  }

  @override
  FutureVoid saveAnalytics({required Analytics analytics}) async {
    try {
      final save = await _firestore
          .collection('analytics')
          .doc(_auth.currentUser!.uid)
          .set(analytics.toMap());
      return right(save);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  FutureVoid updateAnalytics({required Map<String, dynamic> update}) async {
    try {
      final save = await _firestore
          .collection('analytics')
          .doc(_auth.currentUser!.uid)
          .update(update);
      return right(save);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
