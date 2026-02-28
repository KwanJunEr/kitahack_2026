import 'package:flutter/material.dart';
import 'package:kitahack_2026/widgets/custom_navigation_bar.dart';
// Import your custom navigation widget file here
// import 'package:your_app/widgets/custom_bottom_nav.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track the tickable reminders
  final Map<String, bool> _reminders = {
    'Prune Tomato Vines': true,
    'Check pH levels': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome Jonas',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Green Valley Community',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.notifications_none, size: 28),
                      ],
                    ),
                    const SizedBox(height: 20),

                     const Text(
                      'News',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Featured Cards
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _featuredCard(
                              'Urban Farming in Malaysia',
                              'New hydroponic techniques trending',
                              'assets/urban_farm.jpg'),
                          _featuredCard(
                              'Vertical Gardening',
                              'Boost your harvest efficiently',
                              'assets/vertical_garden.jpg'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                

                    const SizedBox(height: 20),

                    // Quick Insights & Reminders
                    const Text(
                      'Quick Insights & Reminders',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ..._reminders.keys.map((title) {
                      return _reminderTile(
                        title,
                        title == 'Prune Tomato Vines'
                            ? 'Due: Today, 4:00 PM'
                            : 'Due: Tomorrow, 9:00 AM',
                        _reminders[title]!,
                      );
                    }).toList(),

                    const SizedBox(height: 20),

                    // Current Performance
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Your garden is 15% more productive this week!\nKeep up the great work.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Urgent Care
                    const Text(
                      'Urgent Care',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          UrgentCareCard('Cherry Tom', 'Lack of Nutrients'),
                          UrgentCareCard('Aloe Vera', 'Needs Sun'),
                          UrgentCareCard('Sweet Basil', 'Water Stress'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _featuredCard(String title, String subtitle, String imagePath) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.3), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _newsCard(String title, String imagePath) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _reminderTile(String title, String subtitle, bool done) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: done,
          onChanged: (value) {
            setState(() {
              _reminders[title] = value!;
            });
          },
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

class UrgentCareCard extends StatelessWidget {
  final String title;
  final String issue;
  const UrgentCareCard(this.title, this.issue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_florist, size: 36, color: Colors.redAccent),
          const SizedBox(height: 8),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(issue,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}