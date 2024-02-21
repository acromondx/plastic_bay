import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/api/local_database/isar_service.dart';
import 'package:plastic_bay/theme/app_color.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartFutureProvider);
    return cart.when(data: (cart) {
      return Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.primaryColor,
            ),
            onPressed: () {},
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                cart.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const CircularProgressIndicator();
    });

    // Stack(
    //   children: [
    //     IconButton(
    //       icon: const Icon(
    //         Icons.shopping_cart,
    //         color: AppColors.primaryColor,
    //       ),
    //       onPressed: () {},
    //     ),
    //     Positioned(
    //       right: 5,
    //       top: 5,
    //       child: Container(
    //         padding: const EdgeInsets.all(2),
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         constraints: const BoxConstraints(
    //           minWidth: 16,
    //           minHeight: 16,
    //         ),
    //         child: const Text(
    //           '5',
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 10,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
