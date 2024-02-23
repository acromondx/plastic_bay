import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/api/providers.dart';
import 'package:waste_company/model/analytics.dart';
import 'package:waste_company/utils/loading_alert.dart';

import '../widget/dashboard_cart.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(analyticsFutureProvider);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: analytics.when(
              data: (result) {
                return Column(
                  children: [
                    DashBoardCard(
                      analytics: result
                    )
                  ],
                );
              },
              error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const LoadingIndicator())),
    );
  }
}
