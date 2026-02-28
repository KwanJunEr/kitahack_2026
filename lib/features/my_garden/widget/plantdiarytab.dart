import 'package:flutter/material.dart';

class PlantDetailTabDiary extends StatefulWidget {
  final String name;

  const PlantDetailTabDiary({super.key, required this.name});

  @override
  State<PlantDetailTabDiary> createState() => _PlantDetailTabDiaryState();
}

class _PlantDetailTabDiaryState extends State<PlantDetailTabDiary> {
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<Map<String, String>> _entries = [
    {
      'title': 'First sprout!',
      'time': '2 days ago',
      'image': 'assets/images/diary1.png',
    },
    {
      'title': 'Looking healthy',
      'time': '1 week ago',
      'image': 'assets/images/diary2.png',
    },
    {
      'title': 'New leaves',
      'time': '2 weeks ago',
      'image': 'assets/images/diary3.png',
    },
  ];

  @override
  void dispose() {
    _waterController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Recent Entries header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Entries',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4F4D),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Show All History',
                  style: TextStyle(
                    color: Color(0xFF0F6D6A),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          /// Horizontal scrollable diary images
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _entries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return _DiaryEntryCard(
                  title: entry['title']!,
                  time: entry['time']!,
                  imagePath: entry['image']!,
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          /// Take Photo / Upload
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4F3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF0F6D6A),
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.camera_alt_outlined,
                      color: Color(0xFF0F6D6A), size: 28),
                  SizedBox(height: 6),
                  Text(
                    'Take Photo / Upload',
                    style: TextStyle(
                      color: Color(0xFF0F6D6A),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// Analyze Plant Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6D6A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Icon(Icons.auto_awesome,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analyze Plant',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'AI-powered health check',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// Water Amount
          Row(
            children: const [
              Icon(Icons.water_drop_outlined,
                  color: Color(0xFF0F6D6A), size: 18),
              SizedBox(width: 6),
              Text(
                'Water Amount (ml)',
                style: TextStyle(
                  color: Color(0xFF0F6D6A),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _waterController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g. 250',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixText: 'ml',
              suffixStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFEBF4F3),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Notes
          Row(
            children: const [
              Icon(Icons.edit_note, color: Color(0xFF0F6D6A), size: 20),
              SizedBox(width: 6),
              Text(
                'Notes',
                style: TextStyle(
                  color: Color(0xFF0F6D6A),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'How is your plant doing today?',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFEBF4F3),
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// Save Entry Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6D6A),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                _waterController.clear();
                _notesController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Diary entry saved!'),
                    backgroundColor: Color(0xFF0F6D6A),
                  ),
                );
              },
              child: const Text(
                'Save Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiaryEntryCard extends StatelessWidget {
  final String title;
  final String time;
  final String imagePath;

  const _DiaryEntryCard({
    required this.title,
    required this.time,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 140,
                height: 100,
                color: const Color(0xFFDDEBEA),
                child: const Icon(Icons.eco,
                    color: Color(0xFF0F6D6A), size: 40),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF0F4F4D),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}