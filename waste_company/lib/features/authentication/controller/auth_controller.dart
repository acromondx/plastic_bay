import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_company/api/authentication/auth_api.dart';
import 'package:waste_company/api/providers.dart';
import 'package:waste_company/api/user_management/user_api.dart';
import 'package:waste_company/model/waste_company.dart';
import 'package:waste_company/routes/route_path.dart';
import 'package:waste_company/utils/toast_message.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider),
      userManagementAPI: ref.watch(userManagementApiProvider),
      messaging: ref.watch(firebaseMassagingProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserManagementAPI _userManagementAPI;
  final FirebaseMessaging _firebaseMessaging;
  AuthController({
    required AuthAPI authAPI,
    required UserManagementAPI userManagementAPI,
    required FirebaseMessaging messaging,
  })  : _userManagementAPI = userManagementAPI,
        _authAPI = authAPI,
        _firebaseMessaging = messaging,
        super(false);

  void register({
    required String email,
    required String password,
    required String companyName,
    required int phoneNumber,
    required BuildContext context,
  }) async {
    state = true;
    final signUp =
        await _authAPI.emailAndPasswordSignUp(email: email, password: password);
    final geoPoint = await Geolocator.getCurrentPosition();
    final notificationToken = await _firebaseMessaging.getToken();
    signUp.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (userCredentials) async {
      final user = userCredentials.user!;
      WasteCompany wasteCompany = WasteCompany(
        id: user.uid,
        companyName: companyName,
        email: email,
        phoneNumber: phoneNumber,
        notificationToken: notificationToken!,
        logo: '',
        location: GeoPoint(geoPoint.latitude, geoPoint.longitude),
      );
      final saveUserDetails =
          await _userManagementAPI.saveCredentials(wasteCompany: wasteCompany);
      saveUserDetails.fold((failure) {
        state = false;
        showToastMessage(failure.error.toString(), context);
      }, (r) {
        state = false;
        context.goNamed(RoutePath.home);
      });
    });
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final login = await _authAPI.login(email: email, password: password);
    login.fold((failure) => showToastMessage(failure.error.toString(), context),
        (userCredentials) async {
      final notificationToken = await _firebaseMessaging.getToken();
      final updateNotificationToken = await _userManagementAPI
          .updateCredentials(
              wasteCompanyId: userCredentials.user!.uid,
              update: {'notificationToken': notificationToken});
      updateNotificationToken.fold(
          (failure) => showToastMessage(failure.error.toString(), context),
          (r) => context.goNamed(RoutePath.home));
    });
  }
}
