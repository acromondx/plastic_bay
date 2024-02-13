import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'api/local_database/isar_service.dart';
import 'features/authentication/screen/register.dart';
import 'firebase_options.dart';
import 'test_screens/myprofile.dart';
import 'test_screens/reward_catalog.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final dir = await getApplicationDocumentsDirectory();
  // final isar = await Isar.open([], directory: dir.path);
  runApp(ProviderScope(
    overrides: [
     // isarProvider.overrideWithValue(IsarServices(isar)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyProfile(),
    );
  }
}
