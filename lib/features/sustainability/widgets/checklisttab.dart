import 'package:flutter/material.dart';
import 'dart:async';

class ChecklistTab extends StatefulWidget {
  const ChecklistTab({super.key});

  @override
  State<ChecklistTab> createState() => _ChecklistTabState();
}

class _ChecklistTabState extends State<ChecklistTab> {
  final List<_GreenTask> _tasks = [
    _GreenTask(title: 'Reduce Plastic Use', subtitle: 'Avoid single-use plastics', isCompleted: true),
    _GreenTask(title: 'Use Public Transport', subtitle: 'Reduce carbon footprint', isCompleted: false),
    _GreenTask(title: 'Save Water', subtitle: 'Shorter showers and fixing leaks', isCompleted: true),
    _GreenTask(title: 'Eat More Plant-based', subtitle: 'Lower environmental impact', isCompleted: false),
    _GreenTask(title: 'Recycle Properly', subtitle: 'Separate waste for recycling', isCompleted: false),
  ];

  bool _isLoading = false;
  int? _sustainabilityScore;
  List<String>? _tips;

  int get _completedCount => _tasks.where((t) => t.isCompleted).length;

  void _generateScore() {
    setState(() {
      _isLoading = true;
      _sustainabilityScore = null;
      _tips = null;
    });

    // Simulate some loading delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _sustainabilityScore = 78; // Hardcoded score
        _tips = [
          "Use reusable bags and bottles",
          "Plant native species in your garden",
          "Reduce meat consumption to 2-3 times per week",
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eco Progress Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1A6B5A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    Icons.eco,
                    size: 100,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Eco-Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You've completed $_completedCount checklist items this week. Keep going!",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _completedCount / _tasks.length,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Daily Green Tasks
          const Text(
            'Checklist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),

          ..._tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _TaskCard(
                task: task,
                onToggle: () {
                  setState(() {
                    _tasks[index].isCompleted = !_tasks[index].isCompleted;
                  });
                },
              ),
            );
          }),

          const SizedBox(height: 20),

          // Generate Sustainable Score Button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                backgroundColor: const Color(0xFF1A6B5A),
                foregroundColor: Colors.white, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _isLoading ? null : _generateScore,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text(
                      'Generate Sustainable Score',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),

          const SizedBox(height: 20),

          // Display Score & Tips
          if (_sustainabilityScore != null && _tips != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Sustainability Score: $_sustainabilityScore',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A6B5A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tips to improve:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ..._tips!.map(
                    (tip) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_right, size: 20, color: Color(0xFF1A6B5A)),
                          const SizedBox(width: 6),
                          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _GreenTask {
  final String title;
  final String subtitle;
  bool isCompleted;

  _GreenTask({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });
}

class _TaskCard extends StatelessWidget {
  final _GreenTask task;
  final VoidCallback onToggle;

  const _TaskCard({required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted ? const Color(0xFF1A6B5A) : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted ? const Color(0xFF1A6B5A) : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}