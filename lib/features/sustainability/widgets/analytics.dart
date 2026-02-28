import 'package:flutter/material.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sustainability Score Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sustainability Score',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.trending_up, color: Color(0xFF1A6B5A), size: 14),
                          SizedBox(width: 4),
                          Text(
                            '+12%',
                            style: TextStyle(
                              color: Color(0xFF1A6B5A),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  '88/100',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 16),
                // Simple line chart using CustomPainter
                SizedBox(
                  height: 120,
                  child: CustomPaint(
                    size: const Size(double.infinity, 120),
                    painter: _LineChartPainter(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN'].map((m) {
                    return Text(
                      m,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Stats Cards Row
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.eco,
                  iconColor: const Color(0xFF1A6B5A),
                  iconBg: const Color(0xFFE8F5EE),
                  label: 'CO2 OFFSET',
                  value: '1,240 kg',
                  subtitle: 'Last 30 days',
                  subtitleColor: const Color(0xFF1A6B5A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.water_drop,
                  iconColor: const Color(0xFF2979A0),
                  iconBg: const Color(0xFFE3F2FD),
                  label: 'WATER SAVED',
                  value: '8,450 L',
                  subtitle: 'Optimized irrigation',
                  subtitleColor: const Color(0xFF2979A0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Recent Milestones
          const Text(
            'Recent Milestones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 14),

          _MilestoneCard(
            icon: Icons.military_tech,
            iconBg: const Color(0xFFE8F5EE),
            iconColor: const Color(0xFF1A6B5A),
            title: 'Zero-Waste Badge',
            subtitle: 'Achieved 95% waste recycling last week',
          ),
          const SizedBox(height: 10),
          _MilestoneCard(
            icon: Icons.solar_power,
            iconBg: const Color(0xFFECF3FF),
            iconColor: const Color(0xFF3B5CC2),
            title: 'Renewable Push',
            subtitle: 'Solar usage increased by 22% in May',
          ),
          const SizedBox(height: 10),

          // Tips Section
          const SizedBox(height: 8),
          const Text(
            'Green Tips',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 14),

          ..._tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _TipCard(tip: tip),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

final _tips = [
  _Tip(
    emoji: '🌱',
    title: 'Layer your compost',
    body: 'Alternate green (nitrogen-rich) and brown (carbon-rich) materials for faster decomposition.',
  ),
  _Tip(
    emoji: '💧',
    title: 'Collect morning dew',
    body: 'Place flat surfaces in your garden to collect condensation — free water for seedlings.',
  ),
  _Tip(
    emoji: '🌻',
    title: 'Plant companion crops',
    body: 'Basil near tomatoes repels pests naturally, reducing the need for pesticides.',
  ),
  _Tip(
    emoji: '♻️',
    title: 'Cardboard as mulch',
    body: 'Lay cardboard under wood chips to suppress weeds — it biodegrades over the season.',
  ),
];

class _Tip {
  final String emoji;
  final String title;
  final String body;
  const _Tip({required this.emoji, required this.title, required this.body});
}

class _TipCard extends StatelessWidget {
  final _Tip tip;
  const _TipCard({required this.tip});

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FAF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(tip.emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.body,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final String subtitle;
  final Color subtitleColor;

  const _MetricCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _MilestoneCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final data = [0.2, 0.25, 0.35, 0.45, 0.5, 0.55, 0.52, 0.65, 0.7, 0.68, 0.82, 0.88];
    final paint = Paint()
      ..color = const Color(0xFF1A6B5A)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      final x = i / (data.length - 1) * size.width;
      final y = size.height - data[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    fillPaint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF1A6B5A).withOpacity(0.2),
        const Color(0xFF1A6B5A).withOpacity(0.0),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw dashed horizontal lines
    final dashPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    for (double y in [size.height * 0.25, size.height * 0.5, size.height * 0.75]) {
      _drawDashedLine(canvas, Offset(0, y), Offset(size.width, y), dashPaint);
    }

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw last point dot
    final lastX = size.width;
    final lastY = size.height - data.last * size.height;
    canvas.drawCircle(
      Offset(lastX, lastY),
      5,
      Paint()..color = const Color(0xFF1A6B5A),
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      3,
      Paint()..color = Colors.white,
    );
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double distance = 0;
    final totalDistance = (end - start).distance;
    final direction = (end - start) / totalDistance;

    while (distance < totalDistance) {
      final dashEnd = distance + dashWidth < totalDistance ? distance + dashWidth : totalDistance;
      canvas.drawLine(
        start + direction * distance,
        start + direction * dashEnd,
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}