import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/api/core/either.dart';
import 'package:plastic_bay/api/storage_bucket/storage_interface.dart';

class StorageAPI implements StorageInterface {
  final FirebaseStorage _firebaseStorage;
  StorageAPI({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
  @override
  FutureVoid deleteImage(String imageUrl) async {
    try {
      final delete = await _firebaseStorage.refFromURL(imageUrl).delete();
      return right(delete);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<String> uploadPostImage({
    required String imagePath,
    required String postId,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child('post_images').child(postId);
      await ref.putFile(File(imagePath));
      return await ref.getDownloadURL();
    } catch (error) {
      return 'Error';
    }
  }

  @override
  Future<String> uploadProfileImage({
    required String imagePath,
    required String userId,
  }) async {
    try {
      final ref = _firebaseStorage
          .ref()
          .child('profile_images')
          .child(userId)
          .child(imagePath);
      await ref.putFile(File(imagePath));
      return await ref.getDownloadURL();
    } catch (error) {
      return 'Error';
    }
  }
}
