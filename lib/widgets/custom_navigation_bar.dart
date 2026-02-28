import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(context, Icons.groups, "/community"),
            _navItem(context, Icons.park, "/garden"),
            _navItem(context, Icons.home, "/home", isCenter: true),
            _navItem(context, Icons.eco, "/sustainability"),
            _navItem(context, Icons.person, "/profile"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String route, {
    bool isCenter = false,
  }) {
    final color = isCenter ? const Color(0xFF0F6D6A) : Colors.black54;

    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isCenter ? 12 : 8),
              decoration: BoxDecoration(
                color: isCenter
                    ? const Color(0xFF0F6D6A).withOpacity(0.15)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: isCenter ? 30 : 24, color: color),
            ),
          ],
        ),
      ),
    );
  }
}