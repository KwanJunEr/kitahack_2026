import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/auth/presentation/signup_loading_setup.dart';
import 'setup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  void _onSignUp() async {
    setState(() => isLoading = true);

    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignUpLoadingScreen(),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );

    setState(() => isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SetupScreen()),
    );
  }

  InputDecoration _input(String hint, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FuturaGrow"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE6F4F1), Color(0xFFD7ECE7)],
                ),
              ),
              child: const Center(
                child: Text(
                  "Grow Your Future",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text("Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              "Join our sustainable community and start your green journey today.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            TextField(style: const TextStyle(color: Colors.black),decoration: _input("Full Name", Icons.person)),
            const SizedBox(height: 14),
            TextField(style: const TextStyle(color: Colors.black),decoration: _input("Email Address", Icons.email)),
            const SizedBox(height: 14),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration:
                  _input("Password", Icons.lock, suffix: const Icon(Icons.visibility)),
            ),
            const SizedBox(height: 14),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: _input("Confirm Password", Icons.lock_outline),
            ),
            const SizedBox(height: 14),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: _input("House Address", Icons.home),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6D6A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Sign Up",
                   style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
