import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/plastic_mangement/pastic_management_api.dart';
import 'package:plastic_bay/model/plastic_post.dart';

class PlasticManagementController extends StateNotifier<bool> {
  final PlasticManagementAPI _plasticManagementAPI;
  PlasticManagementController({
    required PlasticManagementAPI plasticManagementAPI,
  })  : _plasticManagementAPI = plasticManagementAPI,
        super(false);

  void createPost() async {
    final post =
        await _plasticManagementAPI.createPost(plasticPost: plasticPost);
    post.fold((l) => null, (r) => null);
  }

  void updatePost() async {
    final update =
        await _plasticManagementAPI.updatePost(plasticPost: plasticPost);
    update.fold((l) => null, (r) => null);
  }

  void deletePost() async {
    final delete = await _plasticManagementAPI.deletePost(postId: plasticPost);
    delete.fold((l) => null, (r) => null);
  }

  Future<List<PlasticPost>> get allPost async =>
      await _plasticManagementAPI.getAllPost();

  Future<List<PlasticPost>> myPost(String id) async =>
      await _plasticManagementAPI.getMyPost(contributorId: id);
}
