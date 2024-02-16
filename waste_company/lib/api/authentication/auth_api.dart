import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/authentication/auth_interface.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/model/waste_company.dart';

import '../core/api_failure.dart';

class AuthAPI implements AuthInterface {
  final FirebaseAuth _auth;
  AuthAPI({required FirebaseAuth auth}) : _auth = auth;
  @override
  FutureEither<UserCredential> emailAndPasswordSignUp(
      {required String email, required String password}) async {
    try {
      final createUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(createUser);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final logIn = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(logIn);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }
}
