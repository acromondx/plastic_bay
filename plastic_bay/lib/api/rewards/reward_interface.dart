import 'package:plastic_bay/model/order.dart';

import '../../model/reward.dart';
import '../core/either.dart';

abstract class RewardInterface {
   Future<List<Reward>> rewardCatalog();
  Future<List<Reward>> rewardHistory();
  FutureVoid addRewardItem({required Reward reward});
  FutureVoid updateRewardItem({required String rewardId, required Map<String, dynamic> update});
  FutureVoid placeOrder({required ContributorOrder order});
  Future<List<ContributorOrder>> getOrders();
}
