import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/api/providers.dart';
import 'package:waste_company/features/waste_management/widget/post_card.dart';
import 'package:waste_company/utils/loading_alert.dart';

class PickUps extends ConsumerWidget {
  const PickUps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(acceptedPlasticPostProvider(true));
    final accepted = ref.watch(acceptedPlasticPostProvider(false));
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 5,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Accepted'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: accepted.when(
                    data: (plasticsPosts) {
                      return plasticsPosts.isEmpty
                          ? const Center(
                              child: Text('You have not accepted any post yet'),
                            )
                          : ListView.builder(
                              itemCount: plasticsPosts.length,
                              itemBuilder: (context, index) {
                                return PlasticPostCard(
                                    plastic: plasticsPosts[index]);
                              });
                    },
                    error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                    loading: () => const LoadingIndicator()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: completed.when(
                    data: (plasticsPosts) {
                      return plasticsPosts.isEmpty
                          ? const Center(
                              child:
                                  Text('You have not complete any pickup yet'),
                            )
                          : ListView.builder(
                              itemCount: plasticsPosts.length,
                              itemBuilder: (context, index) {
                                return PlasticPostCard(
                                    plastic: plasticsPosts[index]);
                              });
                    },
                    error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                    loading: () => const LoadingIndicator()),
              ),
            ],
          ),
        ));
  }
}
