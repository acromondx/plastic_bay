import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/routes/route_path.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastic Bay'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Plastic Bay',
            ),
            TextButton(
                onPressed: () => context.goNamed(RoutePath.signUp),
                child: const Text('Go to register'))
          ],
        ),
      ),
    );
  }
}
