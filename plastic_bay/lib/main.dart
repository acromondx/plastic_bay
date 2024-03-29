import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/theme/app_theme.dart';
import 'api/local_database/isar_service.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([RewardSchema], directory: dir.path);
  runApp(ProviderScope(
    overrides: [
      isarProvider.overrideWithValue(IsarServices(isar)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Plastic Bay',
      theme: AppTheme.light(),
      routerConfig: routeConfig,
    );
  }
}
