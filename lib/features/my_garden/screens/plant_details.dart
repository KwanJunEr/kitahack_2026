import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/my_garden/widget/plantchattab.dart';
import 'package:kitahack_2026/features/my_garden/widget/plantdetailtab.dart';
import 'package:kitahack_2026/features/my_garden/widget/plantdiarytab.dart';


class PlantDetailScreen extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;
  final String date;
  final String status;

  const PlantDetailScreen({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F6D6A)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            name.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF0F6D6A),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Color(0xFF0F6D6A)),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFF0F6D6A),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF0F6D6A),
            indicatorWeight: 2.5,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Diary'),
              Tab(text: 'Chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PlantDetailTabDetails(
              name: name,
              subtitle: subtitle,
              image: image,
              date: date,
              status: status,
            ),
            PlantDetailTabDiary(name: name),
            PlantDetailTabChat(name: name),
          ],
        ),
      ),
    );
  }
}