import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_bay/api/core/either.dart';


///Interface for authentication
abstract class  AuthInterface{
   FutureEither<UserCredential> signUp({required String email, required String password});
   FutureEither<UserCredential> signIn({required String email,required String password});
   FutureEither<UserCredential> googleSignIn();
   FutureEither<UserCredential> appleSignIn();
   FutureVoid signOut();
   FutureVoid changePassword({required String oldPassword, required String newPassword, });
   FutureVoid resetPassword({required String email});
   FutureVoid deleteAccount({required String password});
}