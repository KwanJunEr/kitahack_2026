import 'package:flutter/material.dart';

class CropRecommendationsPage extends StatelessWidget {
  final String spaceType;
  final String lightLevel;
  final String spaceSize;

  const CropRecommendationsPage({
    Key? key,
    required this.spaceType,
    required this.lightLevel,
    required this.spaceSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recommended Crops',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'FLOW A: QUICK START',
                      style: TextStyle(
                        color: Color(0xFF00CDB7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Step 3 of 3',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CDB7)),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Perfect for your space!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on your $spaceType with $lightLevel light',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Crop recommendations
                  _buildCropCard(
                    context,
                    name: 'Basil',
                    emoji: '🌿',
                    difficulty: 'Easy',
                    budget: '\$5 - \$10',
                    timePerWeek: '10 min',
                    harvestTime: '4-6 weeks',
                    description: 'Perfect beginner herb, loves bright light',
                    imageUrl: 'https://images.unsplash.com/photo-1618375569909-3c8616cf7733?w=400',
                    isRecommended: true,
                  ),
                  const SizedBox(height: 16),
                  _buildCropCard(
                    context,
                    name: 'Lettuce',
                    emoji: '🥬',
                    difficulty: 'Easy',
                    budget: '\$3 - \$8',
                    timePerWeek: '15 min',
                    harvestTime: '3-4 weeks',
                    description: 'Fast growing, great for salads',
                    imageUrl: 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=400',
                    isRecommended: false,
                  ),
                  const SizedBox(height: 16),
                  _buildCropCard(
                    context,
                    name: 'Cherry Tomato',
                    emoji: '🍅',
                    difficulty: 'Medium',
                    budget: '\$8 - \$15',
                    timePerWeek: '20 min',
                    harvestTime: '8-10 weeks',
                    description: 'Rewarding harvest, needs support',
                    imageUrl: 'https://images.unsplash.com/photo-1592841200221-a6898f307baa?w=400',
                    isRecommended: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropCard(
    BuildContext context, {
    required String name,
    required String emoji,
    required String difficulty,
    required String budget,
    required String timePerWeek,
    required String harvestTime,
    required String description,
    required String imageUrl,
    required bool isRecommended,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRecommended ? const Color(0xFF00CDB7) : Colors.grey.shade300,
          width: isRecommended ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.local_florist, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              if (isRecommended)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00CDB7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'RECOMMENDED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and emoji
                Row(
                  children: [
                    Text(
                      '$name $emoji',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: difficulty == 'Easy' ? Colors.green.shade100 : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: difficulty == 'Easy' ? Colors.green.shade700 : Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),

                // Stats
                Row(
                  children: [
                    _buildStat(Icons.attach_money, budget),
                    const SizedBox(width: 16),
                    _buildStat(Icons.access_time, timePerWeek),
                    const SizedBox(width: 16),
                    _buildStat(Icons.calendar_today, harvestTime),
                  ],
                ),
                const SizedBox(height: 16),

                // Start button
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Starting $name garden!')),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecommended ? const Color(0xFF00CDB7) : Colors.grey.shade300,
                    foregroundColor: isRecommended ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Start Growing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
