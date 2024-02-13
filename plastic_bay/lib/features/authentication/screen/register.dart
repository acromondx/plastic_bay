import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/features/authentication/controler/auth_controller.dart';

import '../../../utils/enums/plastic_type.dart';
import '../../plastic management/controller/plastic_management_controller.dart';
import '../../rewards/controller/reward_controller.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ref.watch(authApiProvider).authStateChanges != null
            ? Colors.green
            : Colors.red,
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                ref
                    .read(plasticManagementControllerProvider.notifier)
                    .createPost(
                        description: 'A bag containing a pet bottle plastic',
                        pickUpTime: DateTime.now(),
                        plasticType: PlasticType.pet,
                        quantity: 1);
              },
              child: const Text('Register')),
          TextButton(
              onPressed: () {
                Geolocator.requestPermission();
              },
              child: const Text('Request location permission')),
        ],
      )),
    );
  }
}
