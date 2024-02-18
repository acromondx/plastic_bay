import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/constants/ui/svgs.dart';
import 'package:plastic_bay/features/authentication/controler/auth_controller.dart';
import 'package:plastic_bay/routes/route_path.dart';

import '../../../common/bottom_bar_icons.dart';
import '../../../constants/constants.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plastic Bay'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>context.pushNamed(RoutePath.createPost),
          child: const Icon(Icons.add),
        ),
        body: screens[currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex.value,
            onTap: (index) {
              currentIndex.value = index;
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: CustomIcon(
                  isActive: currentIndex.value == 0 ? true : false,
                  assetName: AppSvg.dustBin,
                ),
                label: 'DashBoard',
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(
                  isActive: currentIndex.value == 1 ? true : false,
                  assetName: AppSvg.trendUpLight,
                ),
                label: 'Contributors',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'Rewards',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ]));
  }
}
