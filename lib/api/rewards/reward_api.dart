import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plastic_bay/api/core/api_failure.dart';
import 'package:plastic_bay/model/reward.dart';

import '../core/either.dart';

abstract class RewardInterface {
  FutureVoid redeemReward({required Reward reward});

  Future<List<Reward>> rewardHistory();
}

class RewardAPI implements RewardInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  RewardAPI({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth,
        super();

  @override
  FutureVoid redeemReward({required Reward reward}) async {
    try {
      final redeem = await _firestore
          .collection('rewards')
          .doc(_auth.currentUser!.uid)
          .collection('myRewards')
          .doc(reward.rewardId)
          .set(reward.toMap());
      return right(redeem);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }

  @override
  Future<List<Reward>> rewardHistory() async {
    final rewards = await _firestore
        .collection('rewards')
        .doc(_auth.currentUser!.uid)
        .collection('myRewards')
        .get();
    return rewards.docs.map((e) => Reward.fromMap(e.data())).toList();
  }
}
