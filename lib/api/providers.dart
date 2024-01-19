import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

@riverpod
FirebaseAuth firebaseAuthProvider(FirebaseAuthProviderRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseFirestore firebaseFirestoreProvider(FirebaseFirestoreProviderRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
AuthAPI authApiProvider(AuthApiProviderRef ref) {
  return AuthAPI(firebaseAuth: ref.watch(firebaseAuthProviderProvider));
}
