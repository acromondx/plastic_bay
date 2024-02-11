import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';
import 'package:plastic_bay/model/waste_contributor.dart';

class LeaderBoardController extends StateNotifier<bool> {
  final UserManagementAPI _userManagementAPI;
  LeaderBoardController({required UserManagementAPI userManagementAPI})
      : _userManagementAPI = userManagementAPI,
        super(false);

  Future<List<WasteContributor>> get topContributors async =>
      await _userManagementAPI.topContributors();
}