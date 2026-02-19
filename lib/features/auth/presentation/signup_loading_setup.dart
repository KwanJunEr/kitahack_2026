import 'dart:math';
import 'package:flutter/material.dart';

class SignUpLoadingScreen extends StatefulWidget {
  const SignUpLoadingScreen({super.key});

  @override
  State<SignUpLoadingScreen> createState() => _SignUpLoadingScreenState();
}

class _SignUpLoadingScreenState extends State<SignUpLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget shape(double size, double dx, double dy) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final angle = controller.value * 2 * pi;
        return Transform.translate(
          offset: Offset(dx * sin(angle), dy * cos(angle)),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: const Color(0xFF0F6D6A).withOpacity(0.2),
              borderRadius: BorderRadius.circular(size),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            shape(120, 20, 20),
            shape(80, -20, 30),
            shape(50, 30, -20),
            const Text("Creating your account...",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
