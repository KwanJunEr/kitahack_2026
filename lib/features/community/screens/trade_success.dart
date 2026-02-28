import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/community/widgets/exchange.dart';

class TradeSuccessScreen extends StatelessWidget {
  final ExchangeItemData item;
  final String proposedItem;

  const TradeSuccessScreen({
    super.key,
    required this.item,
    required this.proposedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.celebration,
                size: 80,
                color: Color(0xFF1A6B5A),
              ),
              const SizedBox(height: 24),
              const Text(
                "Trade Successful!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A6B5A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "You exchanged your $proposedItem\nfor ${item.title}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A6B5A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "+50 Points Earned 🎉",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A6B5A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/community');
                },
                child: const Text("Back to Community"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}