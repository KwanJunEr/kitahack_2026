import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: "assets/images/onboarding1.png",
      title: "Map Your Green Space",
      description:
          "Use AI to analyze your space, optimize light, and visualize your farm with AR digital twins.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding2.png",
      title: "Connect with Neighbors",
      description:
          "Explore a local map to swap seeds, share tools, and see virtual garden layouts in your community.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding3.png",
      title: "Your Smart Garden Guide",
      description:
          "AI agents provide pre-planning and continuous support tailored to your unique schedule and environment.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding4.png",
      title: "Grow with Confidence",
      description:
          "Get hyper-personalized crop recommendations, cost estimates, and predicted yields based on your skill level.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding4.png",
      title: "Nurture the Planet",
      description:
          "Turn waste into compost, track your sustainability score, and earn some rewards for every cycle",
    ),
  ];

  void _next() {
    if (_currentIndex == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finish() {
    Navigator.pushReplacementNamed(context, "/sign-up");
  }

  void _skip() {
    _finish();
  }

    @override
  Widget build(BuildContext context) {
    final bool isLast = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: SafeArea(
        child: Column(
          children: [
            /// Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1F6F6D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            /// Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (_, index) {
                  final page = _pages[index];
                  return _OnboardingPage(data: page);
                },
              ),
            ),

            /// Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 26 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? const Color(0xFF1F6F6D)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// Bottom Button (same position all pages)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F6F6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    isLast ? "Create Account" : "Continue",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, 
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),

          /// Image with subtle animation
          Expanded(
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.9, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0E2B2A),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String description;

  _OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
