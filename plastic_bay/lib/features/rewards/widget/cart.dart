import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/api/local_database/isar_service.dart';
import 'package:plastic_bay/routes/route_path.dart';
import 'package:plastic_bay/theme/app_color.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartFutureProvider);
    final textTheme = Theme.of(context).textTheme;
    return cartProvider.when(data: (cartList) {
      return Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.primaryColor,
            ),
            onPressed: () => context.pushNamed(RoutePath.rewardCheckOut),
          ),
          cartList.isEmpty
              ? const SizedBox.shrink()
              : Positioned(
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
                      cartList.length.toString(),
                      style: textTheme.displayMedium!
                          .copyWith(fontSize: 12, color: AppColors.greyColor),
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
  }
}
