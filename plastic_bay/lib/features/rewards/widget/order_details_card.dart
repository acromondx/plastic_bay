import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/theme/app_color.dart';


class OrderDetailsCard extends ConsumerStatefulWidget {
  final Reward reward;
  const OrderDetailsCard({super.key, required this.reward});

  @override
  ConsumerState<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends ConsumerState<OrderDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final reward = widget.reward;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondaryColor,
            )),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(reward.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: Text(
                reward.name,
                style: textTheme.titleMedium!.copyWith(fontSize: 14),
              ),
            ),
            ListTile(
                title: Text(
                  'Total: ♻️${reward.quantity * reward.value}',
                  style: textTheme.titleMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Qty ${reward.quantity.toString()}',
                      style: textTheme.titleMedium!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
