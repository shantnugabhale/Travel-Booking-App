import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/firebase_options.dart';
import 'package:travelapp/auth/login_page.dart';

void main() async {
  // Ensure Flutter engine is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
