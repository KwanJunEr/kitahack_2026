import 'package:flutter/material.dart';
import 'package:kitahack_2026/widgets/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView( // Make the screen scrollable
          child: Column(
            children: [
              // Profile Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.teal),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.teal),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                  ],
                ),
              ),

              // Avatar and Name
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/avatar.png'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '400XP',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Jonas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Chip(label: Text('Gardener'), backgroundColor: Color(0xFFE0F2F1)),
                  SizedBox(width: 8),
                  Chip(label: Text('Level 5'), backgroundColor: Color(0xFFE0F2F1)),
                ],
              ),

              const SizedBox(height: 20),

              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statCard('8', 'PLANTS GROWN', Icons.local_florist),
                    _statCard('5', 'COMMUNITY CONTRIBUTIONS', Icons.favorite),
                    _statCard('12kg', 'CO2 OFFSET', Icons.cloud),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _menuTile(context, 'My Details', Icons.person, '/my_details'),
                    _menuTile(context, 'My Inventory', Icons.inventory, '/my_inventory'),
                    _menuTile(context, 'Shop', Icons.store, '/shop'),
                    _menuTile(context, 'My Rewards', Icons.emoji_events, '/my_rewards'),
                    const SizedBox(height: 20),
                    _logoutTile(context),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bottom Navigation Bar
              const BottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2F1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, IconData icon, String route) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget _logoutTile(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Log Out',
          style: TextStyle(color: Colors.red),
        ),
        onTap: () async {
          try {
            await FirebaseAuth.instance.signOut(); // Firebase logout
            Navigator.pushReplacementNamed(context, '/sign-in'); // Navigate to sign-in screen
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error signing out: $e')),
            );
          }
        },
      ),
    );
  }
}