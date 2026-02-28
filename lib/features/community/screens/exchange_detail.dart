
import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/community/screens/trade_success.dart';
import 'package:kitahack_2026/features/community/widgets/exchange.dart';

class ExchangeDetailScreen extends StatefulWidget {
  final ExchangeItemData item;

  const ExchangeDetailScreen({super.key, required this.item});

  @override
  State<ExchangeDetailScreen> createState() => _ExchangeDetailScreenState();
}

class _ExchangeDetailScreenState extends State<ExchangeDetailScreen> {
  String? selectedItem;

  final List<String> myItems = [
    "Watering Can",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A6B5A)),
        title: Text(
          widget.item.seller,
          style: const TextStyle(
            color: Color(0xFF1A6B5A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Seller message
                _chatBubble(
                  "Hi! I’m offering ${widget.item.title}. Interested to exchange?",
                  false,
                ),
                const SizedBox(height: 12),

                _chatBubble(
                  "Yes! I would like to trade.",
                  true,
                ),
                const SizedBox(height: 24),

                const Text(
                  "Select an item to propose:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),

                ...myItems.map((item) {
                  final isSelected = selectedItem == item;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1A6B5A).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1A6B5A)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.water_drop,
                              color: Color(0xFF1A6B5A)),
                          const SizedBox(width: 12),
                          Text(item),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Propose Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A6B5A),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: selectedItem == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TradeSuccessScreen(
                            item: widget.item,
                            proposedItem: selectedItem!,
                          ),
                        ),
                      );
                    },
              child: const Text(
                "Propose Trade",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF1A6B5A)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}