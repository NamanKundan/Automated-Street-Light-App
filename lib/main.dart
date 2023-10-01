import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sih_app/authentication.dart';
import 'package:sih_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SyncFusion',
      theme: ThemeData.dark(useMaterial3: true),
      home: AuthenticationWrapper(),
    );
  }
}
