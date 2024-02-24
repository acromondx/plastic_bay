import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/api/storage_bucket/storage_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';

import 'package:plastic_bay/model/waste_contributor.dart';
import 'package:plastic_bay/routes/route_path.dart';
import 'package:plastic_bay/utils/toast_message.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAI: ref.watch(authApiProvider),
      userManagementAPI: ref.watch(userManagementApiProvider),
      firebaseMessaging: ref.watch(firebaseMassagingProvider),
      storageAPI: ref.watch(storageApiProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final FirebaseMessaging _firebaseMessaging;
  final UserManagementAPI _userManagementAPI;
  final StorageAPI _storageAPI;
  AuthController(
      {required AuthAPI authAI,
      required UserManagementAPI userManagementAPI,
      required FirebaseMessaging firebaseMessaging,
      required StorageAPI storageAPI})
      : _authAPI = authAI,
        _userManagementAPI = userManagementAPI,
        _firebaseMessaging = firebaseMessaging,
        _storageAPI = storageAPI,
        super(false);

  void register({
    required String email,
    required String password,
    required String name,
    required String imagePath,
    required BuildContext context,
  }) async {
    state = true;
    final reg =
        await _authAPI.emailAndPasswordSignUp(email: email, password: password);
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) async {
      final imageUrl = await _storageAPI.uploadProfileImage(
          imagePath: imagePath, userId: userCredentials.user!.uid);
      final geoPoint = await Geolocator.getCurrentPosition();

      final notificationToken = await _firebaseMessaging.getToken();
      WasteContributor contributor = WasteContributor(
          id: userCredentials.user!.uid,
          name: name,
          email: email,
          notificationToken: notificationToken!,
          contributorLocation: GeoPoint(geoPoint.latitude, geoPoint.longitude),
          joinedAt: DateTime.now(),
          pictureUrl: imageUrl,
          totalPost: 0,
          earnedPoint: 0.0,
          pointsSpent: 0.0,
          pendingPost: 0);
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold(
          (failure) => showToastMessage(failure.error.toString(), context),
          (savedDetails) {
        state = false;
        context.goNamed(RoutePath.home);
        showToastMessage('Hurray! You are now a contributor', context,
            isSuccess: true);
      });
    });
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final reg = await _authAPI.signIn(email: email, password: password);
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) async {
      state = false;
      showToastMessage('We happy to see you back', context, isSuccess: true);
      context.goNamed(RoutePath.home);
    });
  }

  void googleSignIn(BuildContext context) async {
    state = true;
    final reg = await _authAPI.googleSignIn();
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
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
          earnedPoint: 0.0,
          pointsSpent: 0.0,
          pendingPost: 0);
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold((error) => null, (savedDetails) {
        state = false;
        context.goNamed(RoutePath.home);
      });
    });
  }

  void appleSignIn(BuildContext context) async {
    state = true;
    final reg = await _authAPI.appleSignIn();
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
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
        earnedPoint: 0.0,
        pointsSpent: 0.0,
        pendingPost: 0,
      );
      final saveDetails = await _userManagementAPI.saveContributorCredentials(
          wasteContributor: contributor);
      saveDetails.fold(
          (failure) => showToastMessage(failure.error.toString(), context),
          (savedDetails) {
        state = false;
        context.goNamed(RoutePath.home);
      });
    });
  }

  void resetPassword(
      {required String email, required BuildContext context}) async {
    state = true;
    final reg = await _authAPI.resetPassword(email: email);
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) {
      ///show
      state = false;
    });
  }

  void changePassword(
      {required String newPassword,
      required String oldPassword,
      required BuildContext context}) async {
    state = true;
    final reg = await _authAPI.changePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = false;
    });
  }

  void logOut(BuildContext context) async {
    state = true;
    final reg = await _authAPI.signOut();
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) {
      state = false;
    });
  }

  void deleteAccount(
      {required String password, required BuildContext context}) async {
    state = true;
    final reg = await _authAPI.deleteAccount(password: password);
    reg.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) {
      state = false;
    });
  }
}
