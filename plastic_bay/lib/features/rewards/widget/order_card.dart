import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_stack/image_stack.dart';
import 'package:plastic_bay/model/order.dart';
import 'package:plastic_bay/routes/route_path.dart';
import 'package:plastic_bay/theme/app_color.dart';

import '../../../utils/reuseables.dart';

class OrderCard extends StatelessWidget {
  final ContributorOrder order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.pushNamed(RoutePath.orderDetailsScreen, extra: order.rewards),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.secondaryColor),
          ),
          child: ListTile(
            trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(order.orderStatus.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            subtitle: Text(orderDate(order.placedAt)),
            title: SizedBox(
              height: 40,
              child: ImageStack(
                imageList: order.rewards.map((e) => e.imageUrl).toList(),
                totalCount: order.rewards.length,
                imageRadius: 30,
                imageCount: 3,
                imageBorderWidth: 1,
              ),
            ),
          )),
    );
  }
}
