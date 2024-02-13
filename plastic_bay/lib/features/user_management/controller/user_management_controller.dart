import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';

// class UserManagementController extends StateNotifier<bool> {
//   final UserManagementAPI _userManagementAPI;
//   UserManagementController({required UserManagementAPI userManagementAPI}):
//   _userManagementAPI=userManagementAPI,
//   super(false);
//   void

// }

final contributorProfileDetailsProvider = FutureProvider((ref) async {
  final contributorDetails = ref.watch(authApiProvider);
  return await ref.watch(userManagementApiProvider).contributorDetails(
      wasteContributorId: contributorDetails.currentUser.uid);
});
