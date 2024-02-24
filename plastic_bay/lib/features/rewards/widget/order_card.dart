import 'package:flutter/material.dart';
import 'package:plastic_bay/model/order.dart';
import 'package:plastic_bay/theme/app_color.dart';

class OrderCard extends StatelessWidget {
  final ContributorOrder order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.secondaryColor),
      ),
      child: ListTile(
        title: Text(order.orderStatus.name),
        subtitle: Text(order.placedAt.toString()),
        trailing: Text(order.rewards.length.toString()),
      )
    );
  }
}
