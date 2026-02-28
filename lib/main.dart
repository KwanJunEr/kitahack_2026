import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitahack_2026/features/auth/presentation/signin_screen.dart';
import 'package:kitahack_2026/features/auth/presentation/signup_screen.dart';
import 'package:kitahack_2026/features/home/presentation/home.dart';
import 'package:kitahack_2026/features/onboarding/screens/onboarding_screen.dart';
import 'package:kitahack_2026/features/personal_profile/screens/personal_profile.dart';
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
        '/onboarding' : (context) => const OnboardingScreen(),
        '/sign-in' : (context) => const SignInScreen(),
        '/sign-up' : (context) => const SignUpScreen(),
        '/home' : (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      }
    );
  }
}
