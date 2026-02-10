import 'package:flutter/material.dart';
import 'start_plant_page.dart';

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({Key? key}) : super(key: key);

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  String _selectedFilter = 'All Plants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'My Plants',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00CDB7), size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartPlantPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            color: Colors.white,
            height: 64,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                _buildFilterChip('All Plants', true),
                const SizedBox(width: 8),
                _buildFilterChip('Needs Water', false),
                const SizedBox(width: 8),
                _buildFilterChip('Healthy', false),
              ],
            ),
          ),
          
          // AI Growth Analysis Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00CDB7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'AI Growth Analysis',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your garden health is up 12% this week!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Plants List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildPlantCard(
                  name: 'Basil',
                  emoji: '🌿',
                  day: 'DAY 14',
                  phase: 'Growth Phase',
                  hearts: 5,
                  nextAction: 'Next: Water 6pm',
                  nextIcon: Icons.water_drop_outlined,
                  imagePath: 'https://images.unsplash.com/photo-1618375569909-3c8616cf7733?w=400',
                ),
                const SizedBox(height: 16),
                _buildPlantCard(
                  name: 'Lettuce',
                  emoji: '🥬',
                  day: 'DAY 8',
                  phase: 'Seedling Phase',
                  hearts: 3,
                  nextAction: 'Next: Fertilize Tomorrow',
                  nextIcon: Icons.science_outlined,
                  imagePath: 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=400',
                ),
                const SizedBox(height: 16),
                _buildPlantCard(
                  name: 'Succulent',
                  emoji: '🌵',
                  day: 'DAY 45',
                  phase: 'Mature Phase',
                  hearts: 5,
                  nextAction: 'Next: Water in 3 days',
                  nextIcon: Icons.water_drop_outlined,
                  imagePath: 'https://images.unsplash.com/photo-1459156212016-c812468e2115?w=400',
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedFilter == label ? const Color(0xFF00CDB7) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedFilter == label ? const Color(0xFF00CDB7) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: _selectedFilter == label ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: _selectedFilter == label ? Colors.white : Colors.black,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard({
    required String name,
    required String emoji,
    required String day,
    required String phase,
    required int hearts,
    required String nextAction,
    required IconData nextIcon,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hearts
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.favorite,
                            size: 16,
                            color: index < hearts
                                ? const Color(0xFF00CDB7)
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Plant name
                    Text(
                      '$name $emoji',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Day and phase
                    Row(
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          phase,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Plant image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.local_florist, size: 40, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Next action
          Row(
            children: [
              Icon(nextIcon, size: 18, color: const Color(0xFF00CDB7)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  nextAction,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'DETAILS',
                  style: TextStyle(
                    color: Color(0xFF00CDB7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
