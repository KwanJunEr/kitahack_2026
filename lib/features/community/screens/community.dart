import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/community/widgets/communitymaptab.dart';
import 'package:kitahack_2026/features/community/widgets/exchange.dart';

class IndividualCommunityScreen extends StatefulWidget {
  const IndividualCommunityScreen({super.key});

  @override
  State<IndividualCommunityScreen> createState() => _IndividualCommunityScreenState();
}

class _IndividualCommunityScreenState extends State<IndividualCommunityScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    CommunityTab(),
    ExchangeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1A6B5A);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: primaryColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    // Tab icons only
                    _buildNavItem(0, Icons.map_outlined, Icons.map),
                    const SizedBox(width: 16),
                    _buildNavItem(1, Icons.swap_horiz_outlined, Icons.swap_horiz),
                  ],
                ),
              ),
            ),
            // Tab Content
            Expanded(
              child: _tabs[_currentIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon) {
    final isActive = _currentIndex == index;
    const primaryColor = Color(0xFF1A6B5A);

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? primaryColor : Colors.grey[400],
          size: 28,
        ),
      ),
    );
  }
}