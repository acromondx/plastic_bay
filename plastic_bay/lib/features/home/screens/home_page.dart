import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/constants/ui/svgs.dart';
import 'package:plastic_bay/features/authentication/controler/auth_controller.dart';

import '../../../common/bottom_bar_icons.dart';
import '../../../constants/constants.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider.notifier);
    final currentIndex = useState(0);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plastic Bay'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const CustomIcon(
            isActive: false,
            assetName: AppSvg.mailLight,
          ),
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
              // const BottomNavigationBarItem(
              //   icon: Icon(Icons.school),
              //   label: 'School',
              // ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ]));
  }
}
