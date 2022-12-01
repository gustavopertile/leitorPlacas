import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leitor_placas/valid_plates.dart';
import 'add_plates.dart';
import 'dashboard.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placas',
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/validPlates': (context) => const ValidPlates(),
        '/addPlate': (context) => const AddPlate(),
      },
    );
  }
}
