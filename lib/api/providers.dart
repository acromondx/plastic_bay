import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/plastic_mangement/pastic_management_api.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance ;
});
final firebaseFirestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance ;
});

final firebaseMassagingAPI = Provider((ref) {
  return FirebaseMessaging.instance ;
});

final authApiProvider = Provider((ref) {
  return AuthAPI(firebaseAuth: ref.watch(firebaseAuthProvider)) ;
});


final userManagementApiProvider = Provider((ref) {
  return UserManagementAPI(firestore: ref.watch(firebaseFirestoreProvider)) ;
});

final plasticManagementApiProvider = Provider((ref) {
  return PlasticManagementAPI(firestore: ref.watch(firebaseFirestoreProvider)) ;
});


final rewardApiProvider = Provider((ref) {
  return RewardAPI(firestore: ref.watch(firebaseFirestoreProvider), auth:ref.watch(firebaseAuthProvider) ) ;
});


