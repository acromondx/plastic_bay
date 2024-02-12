import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:uuid/uuid.dart';

import '../../../api/providers.dart';

final rewardControllerProvider =
    StateNotifierProvider<RewardsController, bool>((ref) {
  return RewardsController(rewardAPI: ref.watch(rewardApiProvider));
});

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

  void addRewardItem({required Reward reward}) async {
    final add = await _rewardAPI.addRewardItem(reward: reward);

    add.fold((l) => null, (r) => null);
  }
}

List<Reward> dummyRewards = [
  Reward(
    rewardId: const Uuid().v4(),
    name: 'Wooden spoon',
    description: 'Wooden spoon for kitchen use',
    value: 10,
    quantity: 2,
    category: 'Kitchen',
    imageUrl:
        'https://www.shutterstock.com/image-photo/wooden-spoon-placed-on-white-260nw-1716144358.jpg',
  ),
  Reward(
    rewardId: const Uuid().v4(),
    name: 'Wooden cutlery',
    description: 'Wooden cutlery set for kitchen use',
    value: 15,
    quantity: 5,
    category: 'Kitchen',
    imageUrl:
        'https://www.maryeatscake.com.au/cdn/shop/products/cutlery.jpg?v=1667172099',
  ),
  Reward(
      rewardId: const Uuid().v4(),
      name: 'Wooden Chair',
      description: 'Wooden Chair for student and office use',
      value: 15,
      quantity: 5,
      category: 'Furniture',
      imageUrl:
          'https://www.macwest.com.gh/wp-content/uploads/2019/11/wooden_chair.jpg'),
  Reward(
    rewardId: const Uuid().v4(),
    name: 'Wooden Table',
    description: 'Wooden Table for student and office use',
    value: 20,
    quantity: 5,
    category: 'Furniture',
    imageUrl:
        'https://gh.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/89/7981931/1.jpg?7783',
  )
];
