import 'package:firebase_auth/firebase_auth.dart';

import '../core/fpdart.dart';

abstract class AuthInterface {
  FutureEither<UserCredential> emailAndPasswordSignUp({
    required String email,
    required String password,
  });
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  });
  FutureVoid logOut();
}
