import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:plastic_bay/api/authentication/auth_api.dart';
import 'package:plastic_bay/api/local_database/isar_service.dart';
import 'package:plastic_bay/api/rewards/reward_api.dart';
import 'package:plastic_bay/api/user_management/user_api.dart';
import 'package:plastic_bay/constants/constants.dart';
import 'package:plastic_bay/features/user_management/controller/user_management_controller.dart';
import 'package:plastic_bay/model/order.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/utils/enums/order_status.dart';
import 'package:uuid/uuid.dart';

import '../../../api/providers.dart';
import '../../../routes/route_path.dart';

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
  final rewards = await ref.watch(rewardApiProvider).rewardCatalog();
  return rewards;
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

  Future<void> redeemReward({
    required List<Reward> rewards,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = true;
    double totalSpending = 0;
    ContributorOrder order = ContributorOrder(
      orderId: const Uuid().v1(),
      placedAt: DateTime.now(),
      rewards: rewards,
      orderStatus: OrderStatus.pending,
    );
    for (final reward in rewards) {
      totalSpending += reward.value;
      await _rewardAPI.updateRewardItem(rewardId: reward.rewardId, update: {
        'quantity': FieldValue.increment(-reward.quantity),
      });
      await _isarServices.removeAllFromCart(reward.id!);
    }
    await _rewardAPI.placeOrder(order: order);
    final spending = await _userManagementAPI.spendPoint(
        wasteContributorId: _authAPI.currentUser.uid,
        totalSpending: totalSpending);
    spending.fold((l) => null, (r) {
      ref.invalidate(cartFutureProvider);
      ref.invalidate(contributorProfileDetailsProvider);
      state = false;
      context.pushNamed(RoutePath.successfulOrder);
    });
  }
  Future<List<Reward>> get rewardHistory => _rewardAPI.rewardHistory();
  //Future<List<Reward>> get rewardCatalog => _rewardAPI.rewardCatalog();

  ///Local database
  void updateCheckOutItem({
    required WidgetRef ref,
    required Reward reward,
    required bool isAdd,
  }) async {
    final cartList = ref.read(cartFutureProvider).value!;
    for (final cartItem in cartList) {
      if (cartItem.rewardId == reward.rewardId) {
        await ref
            .read(isarProvider)
            .updateCart(
                reward: cartItem.copyWith(
                    quantity:
                        isAdd ? cartItem.quantity + 1 : cartItem.quantity - 1))
            .then((value) {
          ref.invalidate(cartFutureProvider);
        });
      }
    }
  }

  void removeFromCart({required WidgetRef ref, required cartId}) async {
    await ref.read(isarProvider).removeFromCart(cartId: cartId);
    ref.invalidate(cartFutureProvider);
  }
}
