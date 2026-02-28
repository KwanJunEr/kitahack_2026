import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/community/screens/exchange_detail.dart';

class ExchangeItemData {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String category;
  final String seller;
  final String description;
  final Color accentColor;
  final IconData icon;

  const ExchangeItemData({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.category,
    required this.seller,
    required this.description,
    required this.accentColor,
    required this.icon,
  });
}

final List<ExchangeItemData> _exchangeItems = [
  ExchangeItemData(
    title: 'Organic Tomato Seeds',
    subtitle: 'From Mr. Hafiz’s garden',
    imageAsset: 'tomato',
    category: 'Seeds',
    seller: 'Mr. Hafiz',
    description:
        'High-quality organic tomato seeds from local varieties. Suitable for Malaysian climate. Can produce fruit in 60-80 days.',
    accentColor: const Color(0xFFE74C3C),
    icon: Icons.grass,
  ),
  ExchangeItemData(
    title: 'Extra Green Zucchini (3kg)',
    subtitle: 'Homegrown',
    imageAsset: 'zucchini',
    category: 'Vegetables',
    seller: 'Ms. Aishah',
    description:
        'Fresh green zucchini from home cultivation. Surplus harvest from this week. Can be self-collected or delivered within SS15 area.',
    accentColor: const Color(0xFF27AE60),
    icon: Icons.eco,
  ),
  ExchangeItemData(
    title: 'Compost Starter Kit',
    subtitle: 'Ready for pickup',
    imageAsset: 'compost',
    category: 'Compost',
    seller: 'Mr. Rashid',
    description:
        'Starter kit for home composting. Includes compost bucket, starter materials, and a complete guide in English.',
    accentColor: const Color(0xFF8D6E63),
    icon: Icons.recycling,
  ),
  ExchangeItemData(
    title: 'Sourdough Starter',
    subtitle: 'Active natural strain',
    imageAsset: 'sourdough',
    category: 'Food',
    seller: 'Nurul',
    description:
        'Active sourdough starter maintained for 2 years. Ready to use immediately. Includes care instructions and first bread recipe.',
    accentColor: const Color(0xFFFF8F00),
    icon: Icons.bakery_dining,
  ),
  ExchangeItemData(
    title: 'Pandan Sapling',
    subtitle: 'Healthy, ready to transplant',
    imageAsset: 'pandan',
    category: 'Plants',
    seller: 'Ms. Rohani',
    description:
        'Healthy and fresh pandan sapling. Suitable for pot planting or directly in the ground. Genuine Malaysian pandan, not thorny.',
    accentColor: const Color(0xFF2E7D32),
    icon: Icons.local_florist,
  ),
];

class ExchangeTab extends StatelessWidget {
  const ExchangeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Green Valley',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A6B5A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F5F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xFF1A6B5A),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Category chips
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _CategoryChip(label: 'All', isSelected: true),
                    const SizedBox(width: 8),
                    _CategoryChip(label: 'Seeds'),
                    const SizedBox(width: 8),
                    _CategoryChip(label: 'Vegetables'),
                    const SizedBox(width: 8),
                    _CategoryChip(label: 'Compost'),
                    const SizedBox(width: 8),
                    _CategoryChip(label: 'Plants'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            // Items list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _exchangeItems.length,
                itemBuilder: (context, index) {
                  return _ExchangeCard(item: _exchangeItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _TabChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? const Color(0xFF1A6B5A) : Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),
        if (isActive)
          Container(
            height: 2.5,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A6B5A),
              borderRadius: BorderRadius.circular(2),
            ),
          )
        else
          const SizedBox(height: 2.5),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A6B5A) : const Color(0xFFF0F5F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}

class _ExchangeCard extends StatelessWidget {
  final ExchangeItemData item;

  const _ExchangeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Image placeholder
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: item.accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(item.icon, color: item.accentColor, size: 32),
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF1A2A22),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF1A6B5A),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: item.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.category,
                      style: TextStyle(
                        color: item.accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Interested button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExchangeDetailScreen(item: item),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A6B5A),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A6B5A).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Interested',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
