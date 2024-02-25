import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/providers.dart';


// class LeaderBoardController extends StateNotifier<bool> {
//   final UserManagementAPI _userManagementAPI;
//   LeaderBoardController({required UserManagementAPI userManagementAPI})
//       : _userManagementAPI = userManagementAPI,
//         super(false);

//   Future<List<WasteContributor>> get topContributors async =>
//       await _userManagementAPI.topContributors();
// }

final topContributorsProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(userManagementApiProvider).topContributors() ;
});
