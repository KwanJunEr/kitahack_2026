import 'package:flutter/material.dart';

class PlantDetailTabDetails extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;
  final String date;
  final String status;

  const PlantDetailTabDetails({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Hero Image
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 260,
                decoration: const BoxDecoration(
                  color: Color(0xFFDDEBEA),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.eco, size: 80, color: Color(0xFF0F6D6A)),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF0F6D6A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Plant Information Header
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF0F6D6A), size: 22),
                SizedBox(width: 8),
                Text(
                  'Plant Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F4F4D),
                  ),
                ),
              ],
            ),
          ),

          /// Info Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.grain,
                        label: 'SEED TYPE',
                        value: 'F1 Hybrid',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.house_outlined,
                        label: 'LOCATION',
                        value: 'North Balcony',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.calendar_month_outlined,
                        label: 'PLANTED',
                        value: date,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.layers_outlined,
                        label: 'SOIL TYPE',
                        value: 'Loamy Mix',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          /// Set Care Reminders Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F6D6A),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_active_outlined,
                        color: Colors.white),
                    label: const Text(
                      'SET CARE REMINDERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Automatic alerts for watering & fertilizing',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF4F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0F6D6A), size: 22),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0F6D6A),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F4F4D),
            ),
          ),
        ],
      ),
    );
  }
}