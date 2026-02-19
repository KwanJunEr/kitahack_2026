import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String livingType = "Apartment";
  String experience = "Beginner";
  String time = "Medium";

  Set<String> goals = {};

  final goalOptions = [
    "Grow for personal consumption",
    "Sustainability / reduce waste",
    "Hobby / relaxation",
    "Sell or share crops",
  ];

  Widget sectionTitle(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0F6D6A)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget radioTile(String title, String groupValue, Function(String) onTap) {
    return RadioListTile<String>(
      value: title,
      groupValue: groupValue,
      onChanged: (v) => onTap(v!),
      title: Text(title),
      activeColor: const Color(0xFF0F6D6A),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Setup")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Living Type", Icons.home),
            radioTile(
              "Apartment",
              livingType,
              (v) => setState(() => livingType = v),
            ),
            radioTile(
              "Landed house",
              livingType,
              (v) => setState(() => livingType = v),
            ),

            const SizedBox(height: 20),
            sectionTitle("Experience Level", Icons.eco),
            radioTile(
              "Beginner",
              experience,
              (v) => setState(() => experience = v),
            ),
            radioTile(
              "Intermediate",
              experience,
              (v) => setState(() => experience = v),
            ),
            radioTile(
              "Expert",
              experience,
              (v) => setState(() => experience = v),
            ),

            const SizedBox(height: 20),
            sectionTitle("Time Availability", Icons.access_time),
            radioTile(
              "Low (≤15 min/day)",
              time,
              (v) => setState(() => time = v),
            ),
            radioTile("Medium", time, (v) => setState(() => time = v)),
            radioTile("High", time, (v) => setState(() => time = v)),

            const SizedBox(height: 20),
            sectionTitle("Goals", Icons.flag),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: goalOptions.map((goal) {
                final selected = goals.contains(goal);
                return FilterChip(
                  label: Text(goal),
                  selected: selected,
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        goals.add(goal);
                      } else {
                        goals.remove(goal);
                      }
                    });
                  },
                  selectedColor: const Color(0xFF0F6D6A),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Submit setup data
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6D6A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Finish Setup",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
