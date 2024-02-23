import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constant/app_constants.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastic Bay'),
      ),
      body: screens[currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) async {
            currentIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule_outlined), label: 'Pick Ups'),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics), label: 'Analytics'),
          ]),
    );
  }
}
