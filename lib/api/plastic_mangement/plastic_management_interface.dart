import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/constants/enums/post_status.dart';
import 'package:plastic_bay/model/plastic_post.dart';

abstract class PlasticManagementInterface {
  FutureVoid createPost({required PlasticPost plasticPost});
  FutureVoid deletePost({required String postId});
  FutureVoid updatePost({required PlasticPost plasticPost});
  Future<List<PlasticPost>> getAllPost();
  Future<List<PlasticPost>> getMyPost({required String contributorId});

}
