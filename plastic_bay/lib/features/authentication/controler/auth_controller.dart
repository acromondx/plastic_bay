import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';

import 'package:plastic_bay/features/authentication/controler/auth_state.dart';
import 'package:plastic_bay/model/waste_contributor.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    authAI: ref.watch(authApiProvider),
    userManagementAPI: ref.watch(userManagementApiProvider),
    firebaseMessaging: ref.watch(firebaseMassagingAPI),
  );
});

class AuthController extends StateNotifier<AuthState> {
  final AuthAPI _authAPI;
  final FirebaseMessaging _firebaseMessaging;
  final UserManagementAPI _userManagementAPI;
  AuthController(
      {required AuthAPI authAI,
      required UserManagementAPI userManagementAPI,
      required FirebaseMessaging firebaseMessaging})
      : _authAPI = authAI,
        _userManagementAPI = userManagementAPI,
        _firebaseMessaging = firebaseMessaging,
        super(AuthState.initial);

  void register({
    required String email,
    required String password,
    required String name,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.emailAndPasswordSignUp(email: email, password: password);
    reg.fold((failure) {
      print(failure.error);
      state = AuthState.error;
    }, (userCredentials) async {
      final geoPoint = await Geolocator.getCurrentPosition();

      final notificationToken = await _firebaseMessaging.getToken();
      WasteContributor contributor = WasteContributor(
        id: userCredentials.user!.uid,
        name: name,
        email: email,
        notificationToken: notificationToken!,
        contributorLocation: GeoPoint(geoPoint.latitude, geoPoint.longitude),
        joinedAt: DateTime.now(),
        pictureUrl: '',
        totalPost: 0,
        earnedPoint: 0,
        pointsSpent: 0,
      );
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold((error) => print(error.error), (savedDetails) {
        ///Save user details in db after successful signUp and navigate home
        state = AuthState.registered;
      });
    });
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.signIn(email: email, password: password);
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) async {
      ///get user data from db after login and navigate to home
      state = AuthState.loggedIn;
    });
  }

  void googleSignIn() async {
    state = AuthState.loading;
    final reg = await _authAPI.googleSignIn();
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) async {
      final geoPoint = await Geolocator.getCurrentPosition();
      final notificationToken = await _firebaseMessaging.getToken();
      WasteContributor contributor = WasteContributor(
        id: userCredentials.user!.uid,
        name: userCredentials.user!.displayName!,
        email: userCredentials.user!.email!,
        notificationToken: notificationToken!,
        contributorLocation: GeoPoint(geoPoint.latitude, geoPoint.longitude),
        joinedAt: DateTime.now(),
        pictureUrl: userCredentials.user!.photoURL!,
        totalPost: 0,
        earnedPoint: 0,
        pointsSpent: 0,
      );
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold((error) => null, (savedDetails) {
        ///Save user details in db after successful signIn
        state = AuthState.googleSignIn;
      });
    });
  }

  void appleSignIn() async {
    state = AuthState.loading;
    final reg = await _authAPI.googleSignIn();
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) async {
      final geoPoint = await Geolocator.getCurrentPosition();
      final notificationToken = await _firebaseMessaging.getToken();
      WasteContributor contributor = WasteContributor(
        id: userCredentials.user!.uid,
        name: userCredentials.user!.displayName!,
        email: userCredentials.user!.email!,
        notificationToken: notificationToken!,
        contributorLocation: GeoPoint(geoPoint.latitude, geoPoint.longitude),
        joinedAt: DateTime.now(),
        pictureUrl: userCredentials.user!.photoURL!,
        totalPost: 0,
        earnedPoint: 0,
        pointsSpent: 0,
      );
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold((error) => null, (savedDetails) {
        ///Save user details in db after successful signIn
        state = AuthState.appleSignIn;
      });
    });
  }

  void resetPassword({
    required String email,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.resetPassword(email: email);
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///show
      state = AuthState.resetPassword;
    });
  }

  void changePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.changePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = AuthState.changePassword;
    });
  }

  void logOut() async {
    state = AuthState.loading;
    final reg = await _authAPI.signOut();
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = AuthState.changePassword;
    });
  }

  void deleteAccount({
    required String password,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.deleteAccount(password: password);
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = AuthState.changePassword;
    });
  }
}
