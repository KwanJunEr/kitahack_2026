import 'dart:math';
import 'package:flutter/material.dart';

class SignUpFinalLoadingScreen extends StatefulWidget {
  const SignUpFinalLoadingScreen({super.key});

  @override
  State<SignUpFinalLoadingScreen> createState() =>
      _SignUpFinalLoadingScreenState();
}

class _SignUpFinalLoadingScreenState extends State<SignUpFinalLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  int _step = 0;
  final List<String> _messages = [
    "Please wait a moment while we create your profile.",
    "Initializing your profile…",
    "Profile setup complete!"
  ];

  @override
  void initState() {
    super.initState();

    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();

    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    // Update step every 2 seconds
    Future.delayed(const Duration(seconds: 2), _nextStep);
  }

  void _nextStep() {
    if (_step < _messages.length - 1) {
      setState(() => _step++);
      Future.delayed(const Duration(seconds: 2), _nextStep);
    } else {
      // After final step, automatically navigate back or to next screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // Rotating Circle Layer
  Widget rotatingCircle(double size, Color color, double radius, double speed) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (_, __) {
        final angle = _rotationController.value * 2 * pi * speed;
        return Transform.translate(
          offset: Offset(radius * cos(angle), radius * sin(angle)),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  // Pulsing center
  Widget pulsingCenter(double size, Color color) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (_, __) {
        final scale = 0.8 + 0.4 * _pulseController.value;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  rotatingCircle(30, Colors.teal, 70, 1.0),
                  rotatingCircle(20, Colors.tealAccent, 90, -0.7),
                  rotatingCircle(15, Colors.greenAccent, 50, 1.5),
                  pulsingCenter(60, const Color(0xFF0F6D6A)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _messages[_step],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Optional: small moving dots to show activity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, __) {
                    double offset = sin((_pulseController.value + index * 0.3) * pi);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.5 + 0.5 * offset),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}