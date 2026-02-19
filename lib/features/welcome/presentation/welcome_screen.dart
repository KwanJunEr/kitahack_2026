import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _imageFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _imageFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _buttonScale = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// 🌿 Illustration (Fade In)
              Expanded(
                child: FadeTransition(
                  opacity: _imageFade,
                  child: Image.asset(
                    'assets/images/welcome_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// 📝 Text (Slide Up)
              SlideTransition(
                position: _textSlide,
                child: Column(
                  children: const [
                    Text(
                      'Welcome to\nFuturaGrow!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0E6B6B),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Cultivate the future of your city. Join a\ncommunity of urban farmers and grow\nyour own green sanctuary.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7C7C),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_dot(true), _dot(false), _dot(false)],
              ),

              const SizedBox(height: 32),

              /// 🚀 Button (Scale Animation)
              ScaleTransition(
                scale: _buttonScale,
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E6B6B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
                child: const Text(
                  'Already a member? Sign in',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF0E6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0E6B6B) : const Color(0xFFBFD6D6),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
