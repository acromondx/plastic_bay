import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/api/analytics/analytics_api.dart';
import 'package:waste_company/api/user_management/user_api.dart';

import 'authentication/auth_api.dart';
import 'waste_management/waste_management_api.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance;
});
final firebaseFirestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final firebaseMassagingProvider = Provider((ref) {
  return FirebaseMessaging.instance;
});

// final storageProvider = Provider((ref) {
//   return FirebaseStorage.instance;
// });

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authApiProvider).authStateChanges;
});
final authApiProvider = Provider((ref) {
  return AuthAPI(
    auth: ref.watch(firebaseAuthProvider),
  );
});

final userManagementApiProvider = Provider((ref) {
  return UserManagementAPI(firestore: ref.watch(firebaseFirestoreProvider));
});

final plasticPostProvider = FutureProvider((ref) async {
  return ref.watch(plasticManagementApiProvider).getPlasticPost();
});

final plasticManagementApiProvider = Provider((ref) {
  return WasteManagementAPI(
      firestore: ref.watch(firebaseFirestoreProvider),
      auth: ref.watch(firebaseAuthProvider));
});
final acceptedPlasticPostProvider = FutureProvider.family((ref, bool isCompleted,) async {
  return ref.watch(plasticManagementApiProvider).getPlasticPostByCompanyId(isCompleted: isCompleted);
});


final analyticsApiProvider = Provider((ref) {
  return AnalyticsApi(
      firestore: ref.watch(firebaseFirestoreProvider),
      auth: ref.watch(firebaseAuthProvider));
});
// final rewardApiProvider = Provider((ref) {
//   return RewardAPI(
//       firestore: ref.watch(firebaseFirestoreProvider),
//       auth: ref.watch(firebaseAuthProvider));
// });

// final storageApiProvider = Provider((ref) {
//   return StorageAPI(firebaseStorage: ref.watch(storageProvider));
// })

final analyticsFutureProvider = FutureProvider((ref) async {
  return ref.watch(analyticsApiProvider) ;
});