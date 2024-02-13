import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/local_database/isar_service.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';
import 'package:plastic_bay/model/reward.dart';

import '../../../api/providers.dart';

final rewardControllerProvider =
    StateNotifierProvider<RewardsController, bool>((ref) {
  return RewardsController(
    authAPI: ref.watch(authApiProvider),
    rewardAPI: ref.watch(rewardApiProvider),
    isarServices: ref.watch(isarProvider),
    userManagementAPI: ref.watch(userManagementApiProvider),
  );
});

final rewardCatalogFutureProvider = FutureProvider((ref) async {
  return ref.watch(rewardControllerProvider.notifier).rewardCatalog;
});

class RewardsController extends StateNotifier<bool> {
  final RewardAPI _rewardAPI;
  final AuthAPI _authAPI;
  final UserManagementAPI _userManagementAPI;
  final IsarServices _isarServices;
  RewardsController({
    required RewardAPI rewardAPI,
    required AuthAPI authAPI,
    required UserManagementAPI userManagementAPI,
    required IsarServices isarServices,
  })  : _rewardAPI = rewardAPI,
        _userManagementAPI = userManagementAPI,
        _authAPI = authAPI,
        _isarServices = isarServices,
        super(false);

  void redeemReward({required List<Reward> rewards}) async {
    double totalSpending = 0;
    for (final reward in rewards) {
      totalSpending += reward.value;
      await _rewardAPI.redeemReward(reward: reward);
      await _rewardAPI.updateRewardItem(rewardId: reward.rewardId, update: {
        'quantity': FieldValue.increment(-2),
      });
    }

    await _userManagementAPI.spendPoint(
        wasteContributorId: _authAPI.currentUser.uid,
        totalSpending: totalSpending);
  }

  void addToCart({required Reward reward}) async {
    await _isarServices.addToCart(reward: reward);
  }

  void updateCart({required Reward reward}) async {
    await _isarServices.updateCart(reward: reward);
  }

  void removeFromCart({required int cartId}) async {
    await _isarServices.removeFromCart(cartId: cartId);
  }

  Future<List<Reward>> get rewardHistory => _rewardAPI.rewardHistory();
  Future<List<Reward>> get rewardCatalog => _rewardAPI.rewardCatalog();

  void addRewardItem({required Reward reward}) async {
    final add = await _rewardAPI.addRewardItem(reward: reward);

    add.fold((l) => null, (r) => null);
  }
}
