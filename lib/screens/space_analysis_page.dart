import 'package:flutter/material.dart';
import 'dart:io';
import 'crop_recommendations_page.dart';

class SpaceAnalysisPage extends StatefulWidget {
  final String imagePath;
  final String spaceType;

  const SpaceAnalysisPage({
    Key? key,
    required this.imagePath,
    required this.spaceType,
  }) : super(key: key);

  @override
  State<SpaceAnalysisPage> createState() => _SpaceAnalysisPageState();
}

class _SpaceAnalysisPageState extends State<SpaceAnalysisPage> {
  bool _isAnalyzing = true;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    // Simulate AI analysis with progress
    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 150));
      setState(() {
        _progress = i / 100;
      });
    }

    setState(() {
      _isAnalyzing = false;
    });

    // Auto navigate after showing results briefly
    // await Future.delayed(const Duration(seconds: 2));
    // if (mounted) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => CropRecommendationsPage(
    //         spaceType: widget.spaceType,
    //         lightLevel: 'Bright',
    //         spaceSize: 'Medium',
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Space Analysis',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'FLOW A: QUICK START',
                  style: TextStyle(
                    color: Color(0xFF00CDB7),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Step 2 of 3',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.66,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CDB7)),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 32),

            // Image preview
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(widget.imagePath),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Analysis status
            Text(
              _isAnalyzing ? 'Analyzing your ${widget.spaceType.toLowerCase()}...' : 'Analysis Complete!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (_isAnalyzing) ...[
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CDB7)),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 24),

              // Analysis steps
              _buildAnalysisStep('Detecting light conditions', _progress > 0.3),
              _buildAnalysisStep('Measuring space dimensions', _progress > 0.6),
              _buildAnalysisStep('Safety check (kids/pets)', _progress > 0.9),
            ] else ...[
              // Results
              _buildResultCard(
                icon: Icons.wb_sunny,
                title: 'Light Level',
                value: 'Bright',
                description: 'Great for most plants',
                color: Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildResultCard(
                icon: Icons.straighten,
                title: 'Space Size',
                value: 'Medium',
                description: '~2-3 sq meters',
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildResultCard(
                icon: Icons.check_circle,
                title: 'Safety',
                value: 'All Clear',
                description: 'Safe for growing',
                color: Colors.green,
              ),
              const SizedBox(height: 24),

              // Continue button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CropRecommendationsPage(
                        spaceType: widget.spaceType,
                        lightLevel: 'Bright',
                        spaceSize: 'Medium',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00CDB7),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Recommendations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisStep(String text, bool isComplete) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isComplete ? const Color(0xFF00CDB7) : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isComplete ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard({
    required IconData icon,
    required String title,
    required String value,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
