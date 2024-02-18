import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/plastic_mangement/pastic_management_api.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/api/storage_bucket/storage_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance;
});
final firebaseFirestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final firebaseMassagingProvider = Provider((ref) {
  return FirebaseMessaging.instance;
});

final storageProvider = Provider((ref) {
  return FirebaseStorage.instance;
});

final authStateProvider = StreamProvider((ref)  {
  return ref.watch(authApiProvider).authStateChanges;
});
final authApiProvider = Provider((ref) {
  return AuthAPI(firebaseAuth: ref.watch(firebaseAuthProvider));
});

final userManagementApiProvider = Provider((ref) {
  return UserManagementAPI(firestore: ref.watch(firebaseFirestoreProvider));
});

final plasticManagementApiProvider = Provider((ref) {
  return PlasticManagementAPI(firestore: ref.watch(firebaseFirestoreProvider));
});

final rewardApiProvider = Provider((ref) {
  return RewardAPI(
      firestore: ref.watch(firebaseFirestoreProvider),
      auth: ref.watch(firebaseAuthProvider));
});

final storageApiProvider = Provider((ref) {
  return StorageAPI(firebaseStorage: ref.watch(storageProvider));
});
