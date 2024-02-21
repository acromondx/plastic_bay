import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/api/local_database/isar_service.dart';
import 'package:plastic_bay/features/user_management/controller/user_management_controller.dart';
import 'package:plastic_bay/theme/app_color.dart';

import '../../../model/reward.dart';

class RewardDetails extends HookConsumerWidget {
  final Reward reward;
  RewardDetails({super.key, required this.reward});
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(reward.name),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                ref.invalidate(contributorProfileDetailsProvider);
                final cartList = ref.read(cartFutureProvider).value!;
                for (final cartItem in cartList) {
                  if (cartItem.rewardId == reward.rewardId) {
                    reward.copyWith(
                        quantity: cartItem.quantity +
                            int.parse(quantityController.text));
                  }
                  await ref.read(isarProvider).addToCart(reward: reward);
                }
              },
              child: Text(
                'Add to Cart',
                style:
                    textTheme.labelMedium!.copyWith(color: AppColors.greyColor),
              ))),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(reward.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(
                      width: 0.2,
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
              Text(reward.name,
                  style: textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 10),
              Text(reward.description,
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price ${reward.value.toString()}',
                      style: textTheme.titleMedium!.copyWith(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Qty ${reward.quantity.toString()}',
                      style: textTheme.titleMedium!.copyWith(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(22),
                  hintText: 'Enter Quantity',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
