import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/features/rewards/widget/order_card.dart';

import '../../../utils/loading_alert.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersProvider = ref.watch(contributorsOrderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ordersProvider.when(
              data: (orders) {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index){
                   return OrderCard(order: orders[index],);
                });
              },
              error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const LoadingIndicator())),
    );
  }
}
