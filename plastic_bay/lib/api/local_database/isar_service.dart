import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../model/reward.dart';

final isarProvider =
    Provider<IsarServices>((ref) => throw UnimplementedError());

class IsarServices {
  IsarServices(this.isar);

  final Isar isar;

  Future<void> addToCart({required Reward reward}) async {
  }
  Future<void> updateCart({required Reward reward}) async {
  }

  Future<void> removeFromCart({required int cartId}) async {
  }

  Future<List<Reward>> geCart() async {
 return <Reward>[];
  }
}
