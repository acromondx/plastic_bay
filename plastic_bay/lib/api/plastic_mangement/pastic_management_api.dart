import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/api/plastic_mangement/plastic_management_interface.dart';
import 'package:plastic_bay/model/plastic.dart';

class PlasticManagementAPI implements PlasticManagementInterface {
  final FirebaseFirestore _firestore;
  const PlasticManagementAPI({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  FutureVoid createPost({required Plastic plastic}) async {
    try {
      final post = _firestore
          .collection('plastic_post')
          .doc(plastic.plasticId)
          .set(plastic.toMap());
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
      final delete = _firestore.collection('plastic_post').doc(postId).delete();
      return right(delete);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<List<Plastic>> getAllPost() async {
    final posts = await _firestore
        .collection('plastic_post')
        .orderBy('postedAt', descending: true)
        .get();
    return posts.docs.map((e) => Plastic.fromMap(e.data())).toList();
  }

  @override
  Future<List<Plastic>> getMyPost({
    required String contributorId,
  }) async {
    final posts = await _firestore
        .collection('plastic_post')
        .where('contributorId', isEqualTo: contributorId)
        .get();
    return posts.docs.map((e) => Plastic.fromMap(e.data())).toList();
  }

  @override
  FutureVoid updatePost({
    required Plastic plastic,
  }) async {
    try {
      final delete = _firestore
          .collection('post')
          .doc(plastic.plasticId)
          .update(plastic.toMap());
      return right(delete);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
