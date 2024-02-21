import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/plastic_mangement/pastic_management_api.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/api/storage_bucket/storage_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';
import 'package:plastic_bay/utils/enums/plastic_type.dart';
import 'package:plastic_bay/utils/enums/post_status.dart';
import 'package:plastic_bay/model/plastic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plastic_bay/utils/toast_message.dart';
import 'package:uuid/uuid.dart';

final plasticManagementControllerProvider =
    StateNotifierProvider<PlasticManagementController, bool>((ref) {
  return PlasticManagementController(
    plasticManagementAPI: ref.watch(plasticManagementApiProvider),
    authAPI: ref.watch(authApiProvider),
    userManagementAPI: ref.watch(userManagementApiProvider),
    storageAPI: ref.watch(storageApiProvider),
  );
});

final allPlasticPostFutureProvider = FutureProvider((ref) async {
  return ref.watch(plasticManagementControllerProvider.notifier).allPost;
});

final myPlasticPostFutureProvider = FutureProvider((ref) async {
  return ref.watch(plasticManagementControllerProvider.notifier).myPost();
});

class PlasticManagementController extends StateNotifier<bool> {
  final PlasticManagementAPI _plasticManagementAPI;
  final AuthAPI _authAPI;
  final UserManagementAPI _userManagementAPI;
  final StorageAPI _storageAPI;
  PlasticManagementController({
    required PlasticManagementAPI plasticManagementAPI,
    required UserManagementAPI userManagementAPI,
    required AuthAPI authAPI,
    required StorageAPI storageAPI,
  })  : _plasticManagementAPI = plasticManagementAPI,
        _authAPI = authAPI,
        _userManagementAPI = userManagementAPI,
        _storageAPI = storageAPI,
        super(false);

  void createPost({
    required String description,
    required PlasticType plasticType,
    required double quantity,
    required List<String> imagePath,
    required String pickUpDate,
    required String pickUpTime,
    required BuildContext context,
  }) async {
    state = true;
    List<String> imageUrls = [];
    final plasticId = const Uuid().v4();
    for (final path in imagePath) {
      final pictureId = const Uuid().v4();
      final imageUrl = await _storageAPI.uploadPostImage(
        imagePath: path,
        postId: pictureId,
      );
      imageUrls.add(imageUrl);
    }
    final geoPoint = await Geolocator.getCurrentPosition();
    Plastic plastic = Plastic(
      postedAt: DateTime.now(),
      pickUpDate: pickUpDate,
      pickUpTime: pickUpTime,
      location: GeoPoint(geoPoint.latitude, geoPoint.longitude),
      status: PlasticStatus.pending,
      plasticType: plasticType,
      contributorId: _authAPI.currentUser.uid,
      plasticId: plasticId,
      description: description,
      quantity: quantity,
      imageUrl: imageUrls,
      acceptedCompanyId: '',
    );
    final post = await _plasticManagementAPI.createPost(plastic: plastic);
    post.fold((failure) => showToastMessage(failure.error.toString(), context),
        (r) async {
      await _userManagementAPI.updateContributorDetails(
          wasteContributorId: _authAPI.currentUser.uid,
          details: {'totalPost': FieldValue.increment(1)});
      state = false;
      context.pop();
    });
  }

  void updatePost({required Plastic plastic}) async {
    final update = await _plasticManagementAPI.updatePost(plastic: plastic);
    update.fold((l) => null, (r) => null);
  }

  void deletePost({required String postId}) async {
    final delete = await _plasticManagementAPI.deletePost(postId: postId);
    delete.fold((l) => null, (r) => null);
  }

  Future<List<Plastic>> get allPost async =>
      await _plasticManagementAPI.getAllPost();

  Future<List<Plastic>> myPost() async => await _plasticManagementAPI.getMyPost(
      contributorId: _authAPI.currentUser.uid);
}
