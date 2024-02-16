import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waste_company/api/authentication/auth_api.dart';
import 'package:waste_company/api/user_management/user_api.dart';
import 'package:waste_company/model/waste_company.dart';

import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
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
        super(AuthState.initial);

  void register({
    required String email,
    required String password,
    required String companyName,
    required int phoneNumber,
  }) async {
    final signUp =
        await _authAPI.emailAndPasswordSignUp(email: email, password: password);
    final geoPoint = await Geolocator.getCurrentPosition();
    final notificationToken = await _firebaseMessaging.getToken();
    signUp.fold((failure) => null, (userCredentials) async {
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
      saveUserDetails.fold((l) => null, (r) => null);
    });
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    final login = await _authAPI.login(email: email, password: password);
    login.fold((l) => null, (userCredentials) async {
      final notificationToken = await _firebaseMessaging.getToken();
      final updateNotificationToken = await _userManagementAPI
          .updateCredentials(
              wasteCompanyId: userCredentials.user!.uid,
              update: {'notificationToken': notificationToken});
      updateNotificationToken.fold((l) => null, (r) => null);
    });
  }
}
