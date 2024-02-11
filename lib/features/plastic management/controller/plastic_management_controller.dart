import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/plastic_mangement/pastic_management_api.dart';
import 'package:plastic_bay/utils/enums/plastic_type.dart';
import 'package:plastic_bay/utils/enums/post_status.dart';
import 'package:plastic_bay/model/plastic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class PlasticManagementController extends StateNotifier<bool> {
  final PlasticManagementAPI _plasticManagementAPI;
  final AuthAPI _authAPI;
  PlasticManagementController({
    required PlasticManagementAPI plasticManagementAPI,
    required AuthAPI authAPI,
  })  : _plasticManagementAPI = plasticManagementAPI,
        _authAPI = authAPI,
        super(false);

  void createPost({
    required String description,
    required DateTime pickUpTime,
    required PlasticType plasticType,
    required double quantity,
  }) async {
    final plasticId = const Uuid().v4();
    final geoPoint = await Geolocator.getCurrentPosition();
    Plastic plastic = Plastic(
      postedAt: DateTime.now(),
      pickUpTime: pickUpTime,
      location: GeoPoint(geoPoint.latitude, geoPoint.longitude),
      status: PlasticStatus.pending,
      plasticType: plasticType,
      contributorId: _authAPI.currentUserId,
      plasticId: plasticId,
      description: description,
      quantity: quantity,
    );

    final post = await _plasticManagementAPI.createPost(plastic: plastic);
    post.fold((l) => null, (r) => null);
  }

  void updatePost({required Plastic plastic}) async {
    final update =
        await _plasticManagementAPI.updatePost(plastic: plastic);
    update.fold((l) => null, (r) => null);
  }

  void deletePost({required String postId}) async {
    final delete = await _plasticManagementAPI.deletePost(postId: postId);
    delete.fold((l) => null, (r) => null);
  }

  Future<List<Plastic >> get allPost async =>
      await _plasticManagementAPI.getAllPost();

  Future<List<Plastic >> myPost() async =>
      await _plasticManagementAPI.getMyPost(contributorId: _authAPI.currentUserId);
}
