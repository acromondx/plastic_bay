import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../model/reward.dart';

final isarProvider =
    Provider<IsarServices>((ref) => throw UnimplementedError());

final cartFutureProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(isarProvider).geCart();
});

class IsarServices {
  IsarServices(this.isar);

  final Isar isar;

  Future<void> addToCart({required Reward reward}) async {
    await isar.writeTxn(() async => await isar.rewards.put(reward));
  }

  Future<void> updateCart({required Reward reward}) async {
    await isar.writeTxn(() async => await isar.rewards.put(reward));
  }

  Future<void> removeFromCart({required int cartId}) async {
    await isar.writeTxn(() async => await isar.rewards.delete(cartId));
  }

  Future<void> removeAllFromCart(int id) async {
    await isar.writeTxn(() async => await isar.rewards.delete(id));
  }

  Future<List<Reward>> geCart() async {
    final rewards = await isar.rewards.where().findAll();
    return rewards.reversed.toList();
  }
}
