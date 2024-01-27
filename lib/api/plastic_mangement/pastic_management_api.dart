import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/api/plastic_mangement/plastic_management_interface.dart';
import 'package:plastic_bay/model/plastic_post.dart';

class PlasticManagementAPI implements PlasticManagementInterface {
  final FirebaseFirestore _firestore;
  const PlasticManagementAPI({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  FutureVoid createPost({required PlasticPost plasticPost}) async {
    try {
      final post = _firestore
          .collection('post')
          .doc(plasticPost.postId)
          .set(plasticPost.toMap());
      return right(post);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  FutureVoid deletePost({
    required String postId,
  }) async {
    try {
      final delete = _firestore.collection('post').doc(postId).delete();
      return right(delete);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<List<PlasticPost>> getAllPost() async {
    final posts = await _firestore
        .collection('post')
        .orderBy('timestamp', descending: true)
        .get();
    return posts.docs.map((e) => PlasticPost.fromMap(e.data())).toList();
  }

  @override
  Future<List<PlasticPost>> getMyPost({
    required String contributorId,
  }) async {
    final posts = await _firestore
        .collection('post')
        .where('contributorId', isEqualTo: contributorId)
        .get();
    return posts.docs.map((e) => PlasticPost.fromMap(e.data())).toList();
  }

  @override
  FutureVoid updatePost({
    required PlasticPost plasticPost,
  }) async {
    try {
      final delete = _firestore
          .collection('post')
          .doc(plasticPost.postId)
          .update(plasticPost.toMap());
      return right(delete);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
