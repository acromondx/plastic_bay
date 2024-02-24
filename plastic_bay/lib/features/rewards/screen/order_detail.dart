import 'package:flutter/material.dart';
import 'package:plastic_bay/model/reward.dart';

import '../widget/order_details_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<Reward> rewards;
  const OrderDetailsScreen({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              return OrderDetailsCard(
                reward: rewards[index],
              );
            }),
      ),
    );
  }
}
