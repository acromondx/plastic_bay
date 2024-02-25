import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waste_company/features/profile/widgets/profile_tile.dart';
import 'package:waste_company/routes/route_path.dart';
import 'package:waste_company/utils/reuseables.dart';

import '../../../api/providers.dart';
import '../../authentication/controller/auth_controller.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String address = '..';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final detailProvider = ref.watch(companyDetailsFutureProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: detailProvider.when(data: (details) {
              getStreetAddress(details.location).then((value) {
                setState(() {
                  address = value;
                });
              });
              return Column(
                children: [
                  ProfileItemTile(
                    content: details.companyName,
                    title: 'Name',
                  ),
                  ProfileItemTile(
                    content: details.email,
                    title: 'Email',
                  ),
                  ProfileItemTile(
                    content: details.phoneNumber.toString(),
                    title: 'Phone',
                  ),
                  ProfileItemTile(
                    content: address,
                    title: 'Address',
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signOut()
                          .then((value) => context.pushNamed(RoutePath.signUp));
                    },
                    child: const Text('Sign Out',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            }, error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            })));
  }
}
