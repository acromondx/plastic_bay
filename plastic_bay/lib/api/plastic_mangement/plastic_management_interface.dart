
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/model/plastic.dart';

abstract class PlasticManagementInterface {
  FutureVoid createPost({required Plastic plastic});
  FutureVoid deletePost({required String postId});
  FutureVoid updatePost({required Plastic plastic});
  Future<List<Plastic>> getAllPost();
  Future<List<Plastic>> getMyPost({required String contributorId});

}
