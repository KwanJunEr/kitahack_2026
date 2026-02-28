import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/sustainability/widgets/analytics.dart';
import 'package:kitahack_2026/features/sustainability/widgets/checklisttab.dart';
import 'package:kitahack_2026/features/sustainability/widgets/compost.dart';
import 'package:kitahack_2026/widgets/custom_navigation_bar.dart'; // <-- Import your new navbar

class SustainabilityScreen extends StatefulWidget {
  const SustainabilityScreen({super.key});

  @override
  State<SustainabilityScreen> createState() => _SustainabilityScreenState();
}

class _SustainabilityScreenState extends State<SustainabilityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTab = 0;

  final List<String> _tabLabels = ['Checklist', 'Impact', 'Analytics'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _currentTab = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F7F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Sustainability',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.share_outlined,
                  color: Color(0xFF1A1A1A)),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _CustomTabBar(
            tabs: _tabLabels,
            selectedIndex: _currentTab,
            onTabSelected: (index) {
              setState(() => _currentTab = index);
              _tabController.animateTo(index);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChecklistTab(),
          CompostTab(),
          AnalyticsTab(),
        ],
      ),

      // ✅ Replaced old navbar with your new widget
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _CustomTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0EBE8), width: 1),
        ),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final i = entry.key;
          final label = entry.value;
          final isSelected = selectedIndex == i;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1A6B5A)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? const Color(0xFF1A6B5A)
                        : const Color(0xFF888888),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}