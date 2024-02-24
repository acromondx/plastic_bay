import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/features/authentication/controler/auth_controller.dart';
import 'package:plastic_bay/features/profile/widgets/profile_tile.dart';
import 'package:plastic_bay/features/user_management/controller/user_management_controller.dart';
import 'package:plastic_bay/routes/route_path.dart';
import 'package:plastic_bay/theme/app_color.dart';
import 'package:plastic_bay/utils/loading_alert.dart';
import 'package:timeago/timeago.dart' as timeago;

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final contributorProvider = ref.watch(contributorProfileDetailsProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: contributorProvider.when(
              data: (contributor) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(contributor.pictureUrl),
                    ),
                    ProfileItemTile(content: contributor.name, title: 'Name'),
                    ProfileItemTile(content: contributor.email, title: 'Email'),
                    ProfileItemTile(
                        content: timeago.format(contributor.joinedAt),
                        title: 'Joined'),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () =>
                            context.pushNamed(RoutePath.orderScreen),
                        child: Text(
                          'Orders',
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: 18, color: AppColors.greyColor),
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => ref
                            .read(authControllerProvider.notifier)
                            .logOut(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: Text(
                          'Sign Out',
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: 18, color: AppColors.greyColor),
                        ))
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
