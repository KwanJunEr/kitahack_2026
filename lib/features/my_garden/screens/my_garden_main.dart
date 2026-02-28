import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/kickstart_plant/screen/addplant.dart';
import 'package:kitahack_2026/features/my_garden/screens/plant_details.dart';
import 'package:kitahack_2026/widgets/custom_navigation_bar.dart';


class MyGardenScreen extends StatelessWidget {
  const MyGardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> plants = [
      {
        "name": "Bird's Eye Chili",
        "subtitle": "Perfect for Malaysian Condos",
        "image": "assets/images/chili.png",
        "date": "12 Jan 2026",
        "status": "Growing Well",
      },
      {
        "name": "Pandan",
        "subtitle": "Perfect for Landed Homes",
        "image": "assets/images/pandan.png",
        "date": "05 Feb 2026",
        "status": "Growing Well",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Garden",
          style: TextStyle(
            color: Color(0xFF0F6D6A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: const Icon(Icons.menu, color: Color(0xFF0F6D6A)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color(0xFFE1F0EF),
              child: Icon(Icons.notifications_none, color: Color(0xFF0F6D6A)),
            ),
          )
        ],
      ),

      /// ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// ===== STAT CARDS =====
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _StatCard(title: "TOTAL PLANTS", value: "8", icon: Icons.eco),
                  SizedBox(width: 12),
                  _StatCard(title: "HARVESTED", value: "5", icon: Icons.agriculture),
                  SizedBox(width: 12),
                  _StatCard(title: "GARDEN DAYS", value: "42", icon: Icons.calendar_today),
                  SizedBox(width: 12),
                  _StatCard(title: "WATERED", value: "30", icon: Icons.water_drop),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Growing Now",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View History",
                    style: TextStyle(
                      color: Color(0xFF0F6D6A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ===== PLANT LIST =====
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];

                return GestureDetector(
                  onTap: () {
                    /// 🚀 NAVIGATE & PASS DATA
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlantDetailScreen(
                          name: plant["name"]!,
                          subtitle: plant["subtitle"]!,
                          image: plant["image"]!,
                          date: plant["date"]!,
                          status: plant["status"]!,
                        ),
                      ),
                    );
                  },
                  child: _PlantTile(
                    name: plant["name"]!,
                    subtitle: plant["subtitle"]!,
                    image: plant["image"]!,
                    date: plant["date"]!,
                    status: plant["status"]!,
                  ),
                );
              },
            ),
          ],
        ),
      ),

      /// ================= FAB =================
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF0F6D6A),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPlantWizard()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add New Plant"),
      ),

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

/// ================= STAT CARD =================
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDDEBEA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0F6D6A), size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F4F4D),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF0F6D6A),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PLANT TILE =================
class _PlantTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;
  final String date;
  final String status;

  const _PlantTile({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFF0F6D6A)),
                ),
                const SizedBox(height: 8),
                Text(
                  "Planted: $date",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDEBEA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF0F6D6A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}