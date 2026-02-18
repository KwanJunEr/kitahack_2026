import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitahack_2026/features/welcome/presentation/welcome_screen.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'features/splash_screen/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FuturaGrow',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,

      initialRoute: "/",
      routes:{
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      }
    );
  }
}
