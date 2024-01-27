import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';

import 'package:plastic_bay/features/authentication/controler/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAI})
      : _authAPI = authAI,
        super(AuthState.initial);

  void register({
    required String email,
    required String password,
    required String name,
  }) async {
    state = AuthState.loading;
    final reg = await _authAPI.signUp(email: email, password: password);
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signUp and navigate home
      state = AuthState.registered;
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
    }, (userCredentials) {
      ///get user data from db after login and navigate to home
      state = AuthState.loggedIn;
    });
  }

  void googleSignIn() async {
    state = AuthState.loading;
    final reg = await _authAPI.googleSignIn();
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = AuthState.googleSignIn;
    });
  }

  void appleSignIn() async {
    state = AuthState.loading;
    final reg = await _authAPI.googleSignIn();
    reg.fold((failure) {
      state = AuthState.error;
    }, (userCredentials) {
      ///Save user details in db after successful signIn
      state = AuthState.appleSignIn;
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
