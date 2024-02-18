import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plastic_bay/api/authentication/auth_interface.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/api/core/app_signIn_setup.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//Authentication API for all auth services
class AuthAPI implements AuthInterface {
  final FirebaseAuth _firebaseAuth;
  const AuthAPI({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  FutureEither<UserCredential> appleSignIn() async {
    try {
      // final rawNonce = generateNonceForSignUp();
      // final nonce = sha256ofString(rawNonce);

      // final appleCredential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   nonce: nonce,
      // );
      // final oauthCredential = OAuthProvider('apple.com').credential(
      //   idToken: appleCredential.identityToken,
      //   rawNonce: rawNonce,
      // );
      AppleAuthProvider appleProvider = AppleAuthProvider();
      appleProvider = appleProvider.addScope('email');
      appleProvider = appleProvider.addScope('name');
      final credential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);

      return right(credential);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureVoid changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser!.email!,
        password: oldPassword,
      );

      final userCredentials = await _firebaseAuth.currentUser!
          .reauthenticateWithCredential(credential);
      final updatedPassword =
          await userCredentials.user!.updatePassword(newPassword);

      return right(updatedPassword);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  User get currentUser => _firebaseAuth.currentUser!;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  @override
  FutureVoid deleteAccount({
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser!.email!,
        password: password,
      );

      final userCredentials = await _firebaseAuth.currentUser!
          .reauthenticateWithCredential(credential);
      final updatedPassword = await userCredentials.user!.delete();
      return right(updatedPassword);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureEither<UserCredential> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userSignIn =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return right(userSignIn);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureVoid resetPassword({required String email}) async {
    try {
      final reset = await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(reset);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureEither<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final logIn = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(logIn);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureVoid signOut() async {
    try {
      final logOut = await _firebaseAuth.signOut();
      return right(logOut);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }

  @override
  FutureEither<UserCredential> emailAndPasswordSignUp({
    required String email,
    required String password,
  }) async {
    try {
      final createUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(createUser);
    } on FirebaseAuthException catch (error, stackTrace) {
      return left(Failure(error.message!, stackTrace));
    }
  }
}
