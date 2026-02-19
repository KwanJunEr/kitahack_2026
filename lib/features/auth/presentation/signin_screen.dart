import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:kitahack_2026/features/onboarding/screens/onboarding_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _obscurePassword = true;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonTapDown(TapDownDetails _) {
    setState(() => _pressed = true);
  }

  void _onButtonTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// Logo
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F6D6A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.eco, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "FuturaGrow",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F6D6A),
                            ),
                          ),
                        ],
                      ),

                      /// Right back button (overlay)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Welcome back to your sustainable journey.",
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),

                  const SizedBox(height: 32),

                  /// Email
                  const Text(
                    "Email Address",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _animatedField(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: _inputDecoration(
                        "name@example.com",
                        Icons.mail_outline,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF0F6D6A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  _animatedField(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        "Enter your password",
                        Icons.lock_outline,
                        suffix: IconButton(
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              key: ValueKey(_obscurePassword),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// Sign In Button with scale animation
                  GestureDetector(
                    onTapDown: _onButtonTapDown,
                    onTapUp: _onButtonTapUp,
                    onTapCancel: () => setState(() => _pressed = false),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 120),
                      scale: _pressed ? 0.97 : 1,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F6D6A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 6,
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _socialButton(Icons.g_mobiledata, "Google"),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: _socialButton(Icons.apple, "Apple")),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(color: Color(0xFF64748B)),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedField({required Widget child}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.95, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, childWidget) {
        return Transform.scale(scale: value, child: childWidget);
      },
      child: child,
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _socialButton(IconData icon, String label) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
