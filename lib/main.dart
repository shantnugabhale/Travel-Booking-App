import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/firebase_options.dart';
import 'package:travelapp/app_router.dart';
import 'package:travelapp/services/local_storage_service.dart';

void main() async {
  // Ensure Flutter engine is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local storage
  await LocalStorageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Travel Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
