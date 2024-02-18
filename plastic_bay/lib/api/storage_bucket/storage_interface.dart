import 'package:plastic_bay/api/core/either.dart';

abstract class StorageInterface {
  Future<String> uploadProfileImage({required String imagePath, required String userId});
  Future<String> uploadPostImage({required String imagePath, required String postId});
  FutureVoid deleteImage(String imageUrl);
}
