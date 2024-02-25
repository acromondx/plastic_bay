// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/utils/enums/order_status.dart';

class ContributorOrder {
  final String orderId;
  final DateTime placedAt;
  final List<Reward> rewards;
  final  OrderStatus orderStatus;
  ContributorOrder({
    required this.orderId,
    required this.placedAt,
    required this.rewards,
    required this.orderStatus,
  });

  ContributorOrder copyWith({
    String? orderId,
    DateTime? placedAt,
    List<Reward>? rewards,
    OrderStatus? orderStatus,
  }) {
    return ContributorOrder(
      orderId: orderId ?? this.orderId,
      placedAt: placedAt ?? this.placedAt,
      rewards: rewards ?? this.rewards,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'placedAt': placedAt.millisecondsSinceEpoch,
      'rewards': rewards.map((x) => x.toMap()).toList(),
      'orderStatus': orderStatus.name,
    };
  }

  factory ContributorOrder.fromMap(Map<String, dynamic> map) {
    return ContributorOrder(
      orderId: map['orderId'] as String,
      placedAt: DateTime.fromMillisecondsSinceEpoch(map['placedAt'] as int),
      rewards: List<Reward>.from((map['rewards'] as List<dynamic>).map<Reward>((x) => Reward.fromMap(x),),),
      orderStatus: orderStatusFromString(map['orderStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContributorOrder.fromJson(String source) => ContributorOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderId: $orderId, placedAt: $placedAt, rewards: $rewards, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(covariant ContributorOrder other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.orderId == orderId &&
      other.placedAt == placedAt &&
      listEquals(other.rewards, rewards) &&
      other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
      placedAt.hashCode ^
      rewards.hashCode ^
      orderStatus.hashCode;
  }
}
