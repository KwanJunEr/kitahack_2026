import 'package:flutter/material.dart';

class CompostTab extends StatelessWidget {
  const CompostTab({super.key});

  @override
  Widget build(BuildContext context) {
    final recentEntries = [
      _CompostEntry(date: 'Oct 24', weight: '1.2kg', type: null, imagePlaceholderColor: const Color(0xFF4A7C59)),
      _CompostEntry(date: 'Oct 22', weight: '0.8kg', type: null, imagePlaceholderColor: const Color(0xFF8B6914)),
      _CompostEntry(date: 'Oct 19', weight: null, type: 'Turn', imagePlaceholderColor: const Color(0xFF3D6B3A)),
      _CompostEntry(date: 'Oct 15', weight: '2.5kg', type: null, imagePlaceholderColor: const Color(0xFFA0C878)),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Urban Waste Compost',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Track and manage your organic recycling progress.',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'TOTAL COMPOSTED',
                  valueWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '12.5',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A6B5A),
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'kg',
                          style: TextStyle(fontSize: 16, color: Color(0xFF1A6B5A)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'CURRENT BATCH',
                  valueWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.45,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1A6B5A)),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '45%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              label: const Text(
                'Take Photo of Pile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A6B5A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file_outlined, color: Color(0xFF1A6B5A)),
              label: const Text(
                'Upload from Gallery',
                style: TextStyle(
                  color: Color(0xFF1A6B5A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFFCCE5DE), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: const Color(0xFFECF7F4),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Recent Entries
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Entries',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1A6B5A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: recentEntries.length,
            itemBuilder: (context, index) {
              final entry = recentEntries[index];
              return _CompostEntryCard(entry: entry);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final Widget valueWidget;

  const _StatCard({required this.label, required this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          valueWidget,
        ],
      ),
    );
  }
}

class _CompostEntry {
  final String date;
  final String? weight;
  final String? type;
  final Color imagePlaceholderColor;

  const _CompostEntry({
    required this.date,
    required this.weight,
    required this.type,
    required this.imagePlaceholderColor,
  });
}

class _CompostEntryCard extends StatelessWidget {
  final _CompostEntry entry;

  const _CompostEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  entry.imagePlaceholderColor.withOpacity(0.7),
                  entry.imagePlaceholderColor,
                ],
              ),
            ),
            child: Icon(
              entry.type == 'Turn' ? Icons.refresh : Icons.eco,
              color: Colors.white.withOpacity(0.3),
              size: 60,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                entry.weight != null
                    ? '${entry.date} • ${entry.weight}'
                    : '${entry.date} • ${entry.type}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}