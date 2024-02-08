import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/model/reward.dart';

class RewardsController extends StateNotifier<bool> {
  final RewardAPI _rewardAPI;
  RewardsController({required RewardAPI rewardAPI})
      : _rewardAPI = rewardAPI,
        super(false);

  void redeemReward({required Reward reward}) async {
    final redeem = await _rewardAPI.redeemReward(reward: reward);
    redeem.fold((l) => null, (r) => null);
  }
  Future<List<Reward>> get rewardHistory => _rewardAPI.rewardHistory();
}
