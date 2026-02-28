import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ============================================================
// HARDCODED ANALYSIS RESULTS — easy to edit here
// ============================================================
const List<Map<String, Object>> kAnalysisPool = [
  {
    'health': 'Excellent',
    'healthColor': Color(0xFF22C55E),
    'text': '🌿 Your plant looks vibrant and thriving!\n\n'
        '• Leaves show deep green coloration — excellent chlorophyll production.\n'
        '• Maintain current watering schedule, roots are well-hydrated.\n'
        '• Keep in bright indirect light for 6–8 hours daily.\n'
        '• Consider a light nitrogen-rich feed in the next 2 weeks.\n'
        '• Rotate pot 90° weekly for even light distribution.',
  },
  {
    'health': 'Good',
    'healthColor': Color(0xFF84CC16),
    'text': '🌱 Plant is generally healthy with a few areas to watch.\n\n'
        '• Slight leaf curl detected — likely minor temperature stress.\n'
        '• Move away from cold drafts or AC vents.\n'
        '• Water when top 2 cm of soil feels dry.\n'
        '• Trim any yellowing lower leaves to redirect energy.\n'
        '• Wipe leaves with damp cloth to remove dust buildup.',
  },
 
];

// ============================================================
// MAIN WIDGET
// ============================================================

class PlantDetailTabDiary extends StatefulWidget {
  final String name;

  const PlantDetailTabDiary({super.key, required this.name});

  @override
  State<PlantDetailTabDiary> createState() => _PlantDetailTabDiaryState();
}

class _PlantDetailTabDiaryState extends State<PlantDetailTabDiary>
    with SingleTickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────────────────────
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // ── State ─────────────────────────────────────────────────────────────────
  File? _pickedImage;
  bool _isAnalyzing = false;
  Map<String, Object>? _currentAnalysis; // null = not yet analyzed
  final List<Map<String, Object>> _savedEntries = [];

  // ── XP badge animation ────────────────────────────────────────────────────
  late final AnimationController _xpCtrl;

  @override
  void initState() {
    super.initState();
    _xpCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _waterController.dispose();
    _notesController.dispose();
    _xpCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool get _canAnalyze =>
      _waterController.text.trim().isNotEmpty &&
      _notesController.text.trim().isNotEmpty;

  bool get _hasAnalysis => _currentAnalysis != null;

  // ── Image picking ─────────────────────────────────────────────────────────

  Future<void> _pickImage(ImageSource source) async {
    final XFile? file =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (file == null) return;
    setState(() {
      _pickedImage = File(file.path);
      _currentAnalysis = null;
    });
    _xpCtrl.reset();
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Text(
                'Add Plant Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4F4D),
                ),
              ),
              const SizedBox(height: 16),
              _PickerOption(
                icon: Icons.camera_alt_outlined,
                label: 'Take a Photo',
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 10),
              _PickerOption(
                icon: Icons.photo_library_outlined,
                label: 'Choose from Gallery',
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── AI Analysis ───────────────────────────────────────────────────────────

  Future<void> _analyzeWithAI() async {
    setState(() {
      _isAnalyzing = true;
      _currentAnalysis = null;
    });
    _xpCtrl.reset();

    // Simulate loading
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;

    final result = kAnalysisPool[Random().nextInt(kAnalysisPool.length)];

    setState(() {
      _isAnalyzing = false;
      _currentAnalysis = result;
    });

    _xpCtrl.forward();
  }

  // ── Save entry ────────────────────────────────────────────────────────────

  void _saveEntry() {
    final notes = _notesController.text.trim();
    final water = _waterController.text.trim();

    // Derive a short title from the first line of notes
    String title = 'Diary Entry';
    if (notes.isNotEmpty) {
      final firstLine = notes.split('\n').first;
      title = firstLine.length > 30
          ? '${firstLine.substring(0, 30)}…'
          : firstLine;
    }

    final entry = <String, Object>{
      'title': title,
      'time': 'Just now',
      'imagePath': _pickedImage?.path ?? '',
      'water': water,
      'notes': notes,
      if (_currentAnalysis != null) 'analysis': _currentAnalysis!,
    };

    setState(() {
      _savedEntries.insert(0, entry);
      _waterController.clear();
      _notesController.clear();
      _pickedImage = null;
      _currentAnalysis = null;
    });
    _xpCtrl.reset();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0F6D6A),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Diary entry saved!  +20 XP 🏆',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Merge saved + static placeholder entries for the header row
    final List<Map<String, Object>> displayEntries = [
      ..._savedEntries,
      {
        'title': 'First sprout!',
        'time': '2 days ago',
        'imagePath': 'assets/images/diary1.png',
      },
      {
        'title': 'Looking healthy',
        'time': '1 week ago',
        'imagePath': 'assets/images/diary2.png',
      },
      {
        'title': 'New leaves',
        'time': '2 weeks ago',
        'imagePath': 'assets/images/diary3.png',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Recent Entries header ────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Entries',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4F4D),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Show All History',
                  style: TextStyle(
                    color: Color(0xFF0F6D6A),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Horizontal entry cards ───────────────────────────────────────
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: displayEntries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final e = displayEntries[i];
                final path = e['imagePath'] as String;
                return _DiaryEntryCard(
                  title: e['title'] as String,
                  time: e['time'] as String,
                  imagePath: path,
                  isFileImage: path.startsWith('/'),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ── Plant Photo ──────────────────────────────────────────────────
          const _SectionLabel(
              icon: Icons.camera_alt_outlined, label: 'Plant Photo'),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: _showImagePickerSheet,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: _pickedImage != null ? 220 : 110,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4F3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFF0F6D6A), width: 1.5),
              ),
              child: _pickedImage != null
                  ? Stack(fit: StackFit.expand, children: [
                      Image.file(_pickedImage!, fit: BoxFit.cover),
                      // Remove button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _pickedImage = null;
                            _currentAnalysis = null;
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                      // Change button
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: _showImagePickerSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit_outlined,
                                    color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text('Change',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F6D6A).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_a_photo_outlined,
                              color: Color(0xFF0F6D6A), size: 28),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap to take or upload a photo',
                          style: TextStyle(
                            color: Color(0xFF0F6D6A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Water Amount ─────────────────────────────────────────────────
          const _SectionLabel(
              icon: Icons.water_drop_outlined,
              label: 'Water Amount (ml)'),
          const SizedBox(height: 8),
          TextField(
            controller: _waterController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (_) => setState(() {}),
            decoration: _fieldDecoration(hint: 'e.g. 250', suffix: 'ml'),
          ),

          const SizedBox(height: 20),

          // ── Notes ────────────────────────────────────────────────────────
          const _SectionLabel(icon: Icons.edit_note, label: 'Notes'),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 5,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (_) => setState(() {}),
            decoration:
                _fieldDecoration(hint: 'How is your plant doing today?'),
          ),

          const SizedBox(height: 20),

          // ── Analyze button — shown right after Notes when both fields filled ──
          if (_canAnalyze) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6D6A),
                  disabledBackgroundColor:
                      const Color(0xFF0F6D6A).withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                onPressed: _isAnalyzing ? null : _analyzeWithAI,
                child: _isAnalyzing
                    ? const _AnalyzingLoader()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.auto_awesome,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Analyze Plant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'AI-powered health check',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Analysis result box — shown right after Analyze button ────────
          if (_hasAnalysis) ...[
            _AnalysisResultBox(
              analysis: _currentAnalysis!,
              xpCtrl: _xpCtrl,
            ),
            const SizedBox(height: 24),
          ],

          // ── Save Entry button ─────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6D6A),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: _saveEntry,
              child: const Text(
                'Save Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Analysis Result Box
// ============================================================

class _AnalysisResultBox extends StatefulWidget {
  final Map<String, Object> analysis;
  final AnimationController xpCtrl;

  const _AnalysisResultBox({
    required this.analysis,
    required this.xpCtrl,
  });

  @override
  State<_AnalysisResultBox> createState() => _AnalysisResultBoxState();
}

class _AnalysisResultBoxState extends State<_AnalysisResultBox> {
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.25), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: widget.xpCtrl, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color healthColor = widget.analysis['healthColor'] as Color;
    final String health = widget.analysis['health'] as String;
    final String text = widget.analysis['text'] as String;


    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF4F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB2D8D6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header bar ─────────────────────────────────────────────────
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: healthColor.withOpacity(0.12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: healthColor, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'AI Health Analysis',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF0F4F4D),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: healthColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    health,
                    style: TextStyle(
                      color: healthColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFB347), Color(0xFFFFCC02)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                   
                  ),
                ),
              ],
            ),
          ),

          // ── Content text box ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB2D8D6)),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Analyzing loader (dots animation inside button)
// ============================================================

class _AnalyzingLoader extends StatefulWidget {
  const _AnalyzingLoader();

  @override
  State<_AnalyzingLoader> createState() => _AnalyzingLoaderState();
}

class _AnalyzingLoaderState extends State<_AnalyzingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  int _dots = 1;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) {
          setState(() => _dots = (_dots % 3) + 1);
          _ctrl.forward(from: 0);
        }
      });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          'Analyzing${'.' * _dots}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// Reusable small widgets
// ============================================================

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF4F3),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0F6D6A), size: 24),
            const SizedBox(width: 14),
            Text(label,
                style: const TextStyle(
                  color: Color(0xFF0F4F4D),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0F6D6A), size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0F6D6A),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _DiaryEntryCard extends StatelessWidget {
  final String title;
  final String time;
  final String imagePath;
  final bool isFileImage;

  const _DiaryEntryCard({
    required this.title,
    required this.time,
    required this.imagePath,
    this.isFileImage = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget img;
    if (imagePath.isEmpty) {
      img = _placeholder();
    } else if (isFileImage) {
      img = Image.file(File(imagePath),
          width: 140, height: 100, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder());
    } else {
      img = Image.asset(imagePath,
          width: 140, height: 100, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder());
    }

    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12), child: img),
          const SizedBox(height: 6),
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF0F4F4D),
              )),
          Text(time,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
        width: 140,
        height: 100,
        color: const Color(0xFFDDEBEA),
        child: const Icon(Icons.eco, color: Color(0xFF0F6D6A), size: 40),
      );
}

// ============================================================
// Field decoration helper
// ============================================================

InputDecoration _fieldDecoration({required String hint, String? suffix}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixText: suffix,
      suffixStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFFEBF4F3),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Color(0xFF0F6D6A), width: 1.5),
      ),
    );