import '../../model/reward.dart';
import '../core/either.dart';

abstract class RewardInterface {
  FutureVoid redeemReward({required Reward reward});
   Future<List<Reward>> rewardCatalog();
  Future<List<Reward>> rewardHistory();
  FutureVoid addRewardItem({required Reward reward});
}
