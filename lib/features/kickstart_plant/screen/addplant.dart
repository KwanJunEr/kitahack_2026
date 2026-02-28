import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

/// ─────────────────────────────────────────────────────────────
///  SETUP REQUIRED
///
///  1. pubspec.yaml → add dependency:
///       camera: ^0.10.5+9
///
///  2. Android → android/app/build.gradle:
///       minSdkVersion 21
///     AndroidManifest.xml:
///       <uses-permission android:name="android.permission.CAMERA"/>
///
///  3. iOS → Info.plist:
///       <key>NSCameraUsageDescription</key>
///       <string>Camera is used for AR plant placement.</string>
///
///  4. Call from MyGardenScreen FAB:
///       onPressed: () => Navigator.push(context,
///         MaterialPageRoute(builder: (_) => const AddPlantWizard()))
/// ─────────────────────────────────────────────────────────────

class AddPlantWizard extends StatefulWidget {
  const AddPlantWizard({super.key});

  @override
  State<AddPlantWizard> createState() => _AddPlantWizardState();
}

class _AddPlantWizardState extends State<AddPlantWizard>
    with TickerProviderStateMixin {
  int _step = 0;
  final int _totalSteps = 7;

  // Step 0
  String? _budget;
  // Step 1
  String? _timeAvail;
  // Step 2
  String? _selectedCrop;
  bool _loadingCrop = false;
  bool _nutrientReady = false;
  // Step 4
  bool _arPlaced = false;
  late AnimationController _arPulse;
  // Step 5
  String? _placement;
  // Step 6
  double _waterAmount = 500;
  bool _useFertilizer = true;
  bool _useMulch = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  static const _teal = Color(0xFF0F6D6A);

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _arPulse = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
        lowerBound: 0.85,
        upperBound: 1.15)
      ..repeat(reverse: true);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _arPulse.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step < _totalSteps - 1) {
      _fadeCtrl.reset();
      setState(() => _step++);
      _fadeCtrl.forward();
    }
  }

  void _prevStep() {
    if (_step > 0) {
      _fadeCtrl.reset();
      setState(() {
        _step--;
        if (_step == 2) {
          _loadingCrop = false;
          _nutrientReady = false;
        }
        if (_step == 4) _arPlaced = false;
      });
      _fadeCtrl.forward();
    }
  }

  String _cropEmoji(String? crop) {
    switch (crop) {
      case 'Pandan':
        return '🌿';
      case "Bird's Eye Chili":
        return '🌶️';
      case 'Cherry Tomato':
        return '🍅';
      default:
        return '🌿';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _teal),
          onPressed: _step == 0 ? () => Navigator.pop(context) : _prevStep,
        ),
        centerTitle: true,
        title: Text(
          _stepTitle(_step),
          style: const TextStyle(
              color: _teal, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          _StepIndicator(current: _step, total: _totalSteps),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: _buildStep(_step),
            ),
          ),
        ],
      ),
    );
  }

  String _stepTitle(int s) => const [
        'Budget Range',
        'Time Availability',
        'Choose Your Crop',
        'Nutrients & Tools',
        'AR Plant Placement',
        'Placement Options',
        'Growth Simulation',
      ][s];

  Widget _buildStep(int s) {
    switch (s) {
      case 0:
        return _StepBudget(
          selected: _budget,
          onSelect: (v) => setState(() => _budget = v),
          onNext: _budget != null ? _nextStep : null,
        );
      case 1:
        return _StepTime(
          selected: _timeAvail,
          onSelect: (v) => setState(() => _timeAvail = v),
          onNext: _timeAvail != null ? _nextStep : null,
        );
      case 2:
        return _StepCropSelect(
          selectedCrop: _selectedCrop,
          loading: _loadingCrop,
          onSelect: (crop) async {
            setState(() {
              _selectedCrop = crop;
              _loadingCrop = true;
              _nutrientReady = false;
            });
            await Future.delayed(const Duration(seconds: 2));
            if (mounted) {
              setState(() {
                _loadingCrop = false;
                _nutrientReady = true;
              });
            }
          },
          onNext: (_nutrientReady && _selectedCrop != null) ? _nextStep : null,
        );
      case 3:
        return _StepNutrients(
          cropName: _selectedCrop ?? 'Pandan',
          onNext: _nextStep,
        );
      case 4:
        return _StepAR(
          arPlaced: _arPlaced,
          arPulse: _arPulse,
          cropEmoji: _cropEmoji(_selectedCrop),
          onPlaced: () => setState(() => _arPlaced = true),
          onNext: _arPlaced ? _nextStep : null,
        );
      case 5:
        return _StepPlacement(
          selected: _placement,
          onSelect: (v) => setState(() => _placement = v),
          onNext: _placement != null ? _nextStep : null,
        );
      case 6:
        return _StepSimulation(
          cropName: _selectedCrop ?? 'Pandan',
          waterAmount: _waterAmount,
          useFertilizer: _useFertilizer,
          useMulch: _useMulch,
          onWaterChanged: (v) => setState(() => _waterAmount = v),
          onFertilizerToggle: (v) => setState(() => _useFertilizer = v),
          onMulchToggle: (v) => setState(() => _useMulch = v),
          onFinalize: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🌿 Plant added to your garden!'),
                backgroundColor: _teal,
              ),
            );
            Navigator.pop(context);
          },
        );
      default:
        return const SizedBox();
    }
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP INDICATOR
// ─────────────────────────────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  final int current, total;
  const _StepIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        children: [
          Row(
            children: List.generate(total, (i) {
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 5,
                  decoration: BoxDecoration(
                    color: i <= current
                        ? const Color(0xFF0F6D6A)
                        : const Color(0xFFDDEBEA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Step ${current + 1} of $total',
              style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF0F6D6A),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 0 – BUDGET
// ─────────────────────────────────────────────────────────────
class _StepBudget extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;
  const _StepBudget(
      {required this.selected,
      required this.onSelect,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final options = [
      ('Under RM 50', Icons.savings_outlined, 'Seeds + basic pots'),
      ('RM 50–100', Icons.account_balance_wallet_outlined, 'Starter kit'),
      ('RM 100–250', Icons.storefront_outlined, 'Full setup'),
      ('RM 250+', Icons.workspace_premium_outlined, 'Premium garden'),
    ];
    return _WizardShell(
      title: "What's your budget?",
      subtitle: "We'll recommend crops that fit your wallet.",
      onNext: onNext,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.only(top: 8),
        childAspectRatio: 1.3,
        children: options
            .map((o) => _OptionCard(
                  label: o.$1,
                  subtitle: o.$3,
                  icon: o.$2,
                  selected: selected == o.$1,
                  onTap: () => onSelect(o.$1),
                ))
            .toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 1 – TIME AVAILABILITY
// ─────────────────────────────────────────────────────────────
class _StepTime extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;
  const _StepTime(
      {required this.selected,
      required this.onSelect,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final options = [
      ('< 10 min/day', Icons.timer_outlined, 'Almost no effort'),
      ('10–30 min/day', Icons.hourglass_bottom_outlined, 'Low maintenance'),
      ('30–60 min/day', Icons.schedule_outlined, 'Moderate care'),
      ('1 hr+/day', Icons.favorite_outline, 'Garden enthusiast'),
    ];
    return _WizardShell(
      title: 'How much time can you spare?',
      subtitle: "We'll match crops to your lifestyle.",
      onNext: onNext,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.only(top: 8),
        childAspectRatio: 1.3,
        children: options
            .map((o) => _OptionCard(
                  label: o.$1,
                  subtitle: o.$3,
                  icon: o.$2,
                  selected: selected == o.$1,
                  onTap: () => onSelect(o.$1),
                ))
            .toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 2 – CROP SELECT
// ─────────────────────────────────────────────────────────────
class _CropOption {
  final String emoji, name, desc;
  const _CropOption(this.emoji, this.name, this.desc);
}

class _StepCropSelect extends StatelessWidget {
  final String? selectedCrop;
  final bool loading;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;
  const _StepCropSelect(
      {required this.selectedCrop,
      required this.loading,
      required this.onSelect,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final crops = [
      _CropOption('🌿', 'Pandan', 'Easy · Aromatic · Condo-friendly'),
      _CropOption('🌶️', "Bird's Eye Chili", 'Medium · Spicy · Malaysian fav'),
      _CropOption('🍅', 'Cherry Tomato', 'Medium · Sunny · High yield'),
    ];

    if (loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF0F6D6A)),
            SizedBox(height: 20),
            Text('🤖 AI is analysing your crop...',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0F6D6A),
                    fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return _WizardShell(
      title: 'AI Recommended Crops',
      subtitle: 'Tap a crop to analyse nutrients & requirements.',
      onNext: onNext,
      nextLabel: 'View Nutrients →',
      child: Column(
        children: crops.map((c) {
          final isSelected = selectedCrop == c.name;
          return GestureDetector(
            onTap: () => onSelect(c.name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0F6D6A) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0F6D6A)
                      : const Color(0xFFDDEBEA),
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: const Color(0xFF0F6D6A).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Text(c.emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.name,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF0F4F4D))),
                        Text(c.desc,
                            style: TextStyle(
                                fontSize: 13,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle,
                        color: Colors.white, size: 22),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 3 – NUTRIENTS & TOOLS
// ─────────────────────────────────────────────────────────────
class _StepNutrients extends StatelessWidget {
  final String cropName;
  final VoidCallback onNext;
  const _StepNutrients({required this.cropName, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final nutrients = [
      ('Nitrogen (N)', '120 mg/L', 0.7),
      ('Phosphorus (P)', '60 mg/L', 0.45),
      ('Potassium (K)', '95 mg/L', 0.6),
      ('Calcium (Ca)', '40 mg/L', 0.3),
    ];
    final fertilizers = [
      ('🌱 Organic Compost', 'Slow-release, eco-friendly'),
      ('💧 Liquid NPK 15-15-15', 'Balanced growth booster'),
      ('🪨 Dolomite Lime', 'pH stabiliser + calcium'),
    ];
    final tools = [
      ('🪣 5L Watering Can', 'Gentle pour for seedlings'),
      ('🌿 Small Trowel', 'Soil loosening & transplanting'),
      ('📏 pH Meter', 'Monitor soil acidity'),
    ];

    return _WizardShell(
      title: 'Nutrients & Tools',
      subtitle: 'AI-selected for $cropName',
      onNext: onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Nutrient Requirements'),
          const SizedBox(height: 10),
          ...nutrients
              .map((n) => _NutrientBar(name: n.$1, value: n.$2, fraction: n.$3)),
          const SizedBox(height: 20),
          _SectionLabel('Recommended Fertilizers'),
          const SizedBox(height: 10),
          ...fertilizers.map((f) => _InfoTile(emoji: f.$1, desc: f.$2)),
          const SizedBox(height: 20),
          _SectionLabel('Recommended Tools'),
          const SizedBox(height: 10),
          ...tools.map((t) => _InfoTile(emoji: t.$1, desc: t.$2)),
        ],
      ),
    );
  }
}

class _NutrientBar extends StatelessWidget {
  final String name, value;
  final double fraction;
  const _NutrientBar(
      {required this.name, required this.value, required this.fraction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF0F6D6A))),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 8,
              backgroundColor: const Color(0xFFDDEBEA),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF0F6D6A)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String emoji, desc;
  const _InfoTile({required this.emoji, required this.desc});

  @override
  Widget build(BuildContext context) {
    final parts = emoji.split(' ');
    final icon = parts.first;
    final label = parts.sublist(1).join(' ');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFDDEBEA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                Text(desc,
                    style:
                        const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 4 – AR CAMERA (LIVE CAMERA + DRAGGABLE AR OVERLAY)
// ─────────────────────────────────────────────────────────────
class _StepAR extends StatefulWidget {
  final bool arPlaced;
  final AnimationController arPulse;
  final String cropEmoji;
  final VoidCallback onPlaced;
  final VoidCallback? onNext;

  const _StepAR({
    required this.arPlaced,
    required this.arPulse,
    required this.cropEmoji,
    required this.onPlaced,
    required this.onNext,
  });

  @override
  State<_StepAR> createState() => _StepARState();
}

class _StepARState extends State<_StepAR> {
  CameraController? _camCtrl;
  bool _camReady = false;
  bool _camError = false;
  String _errorMsg = '';

  // Normalised 0.0–1.0 position within the viewfinder
  Offset _plantPos = const Offset(0.5, 0.55);

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception('No cameras found.');
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _camCtrl = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await _camCtrl!.initialize();
      if (mounted) setState(() => _camReady = true);
    } catch (e) {
      if (mounted) setState(() {
        _camError = true;
        _errorMsg = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _camCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _WizardShell(
      title: 'AR Plant Placement',
      subtitle: widget.arPlaced
          ? 'Location locked ✓  Tap Continue.'
          : 'Drag the plant to your desired spot, then tap Place.',
      onNext: widget.onNext,
      nextLabel: 'Continue →',
      child: Column(
        children: [
          // ── AR Viewfinder ──
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 340,
              width: double.infinity,
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;

                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      // ── CAMERA OR FALLBACK ──
                      Positioned.fill(
                        child: _camReady && _camCtrl != null
                            ? CameraPreview(_camCtrl!)
                            : _camError
                                ? Container(
                                    color: const Color(0xFF0A2A29),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.no_photography,
                                            color: Colors.white54, size: 40),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            'Camera unavailable\n$_errorMsg',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white54,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    color: const Color(0xFF0A2A29),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          color: Color(0xFF0F6D6A)),
                                    ),
                                  ),
                      ),

                      // ── AR GRID ──
                      Positioned.fill(
                          child: CustomPaint(painter: _ARGridPainter())),

                      // ── CORNER BRACKETS ──
                      const Positioned(top: 12, left: 12, child: _ARCorner()),
                      const Positioned(
                          top: 12, right: 12, child: _ARCorner(flipH: true)),
                      const Positioned(
                          bottom: 12,
                          left: 12,
                          child: _ARCorner(flipV: true)),
                      const Positioned(
                          bottom: 12,
                          right: 12,
                          child: _ARCorner(flipH: true, flipV: true)),

                      // ── DRAGGABLE / PULSING PLANT EMOJI ──
                      Positioned(
                        left: _plantPos.dx * w - 32,
                        top: _plantPos.dy * h - 40,
                        child: GestureDetector(
                          // only draggable before placing
                          onPanUpdate: widget.arPlaced
                              ? null
                              : (d) {
                                  setState(() {
                                    final nx =
                                        (_plantPos.dx + d.delta.dx / w)
                                            .clamp(0.05, 0.95);
                                    final ny =
                                        (_plantPos.dy + d.delta.dy / h)
                                            .clamp(0.05, 0.95);
                                    _plantPos = Offset(nx, ny);
                                  });
                                },
                          child: widget.arPlaced
                              ? AnimatedBuilder(
                                  animation: widget.arPulse,
                                  builder: (_, __) => Transform.scale(
                                    scale: widget.arPulse.value,
                                    child: _PlantPin(
                                      emoji: widget.cropEmoji,
                                      label: '📍 Placed!',
                                      labelColor: Colors.white,
                                    ),
                                  ),
                                )
                              : _PlantPin(
                                  emoji: widget.cropEmoji,
                                  label: 'drag me',
                                  labelColor: Colors.white70,
                                ),
                        ),
                      ),

                      // ── TOP HUD ──
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.fiber_manual_record,
                                  color: Colors.redAccent, size: 9),
                              const SizedBox(width: 4),
                              const Text('LIVE AR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('🌿 Garden Mode',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── BOTTOM HUD – light meter ──
                      if (_camReady && !widget.arPlaced)
                        Positioned(
                          bottom: 10,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.wb_sunny_outlined,
                                    color: Colors.amber, size: 14),
                                const SizedBox(width: 6),
                                const Text('Light: Good',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11)),
                                const Spacer(),
                                const Icon(Icons.crop_free,
                                    color: Colors.white54, size: 14),
                                const SizedBox(width: 4),
                                const Text('Surface detected',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── CTA ──
          if (!widget.arPlaced) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6D6A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: widget.onPlaced,
                icon: const Icon(Icons.pin_drop, color: Colors.white),
                label: const Text(
                  'Place Plant Here',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Drag the emoji on the live feed to your spot, then tap Place.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ] else
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFDDEBEA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF0F6D6A)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Location saved! Tap Continue to see AI placement tips.',
                      style: TextStyle(
                          color: Color(0xFF0F6D6A),
                          fontWeight: FontWeight.w600),
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

/// Small plant pin widget
class _PlantPin extends StatelessWidget {
  final String emoji, label;
  final Color labelColor;
  const _PlantPin(
      {required this.emoji,
      required this.label,
      required this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 52)),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF0F6D6A).withOpacity(0.88),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(label,
              style: TextStyle(
                  color: labelColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// AR painters
class _ARGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF0F6D6A).withOpacity(0.18)
      ..strokeWidth = 0.7;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ARCorner extends StatelessWidget {
  final bool flipH, flipV;
  const _ARCorner({this.flipH = false, this.flipV = false});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: flipH ? -1 : 1,
      scaleY: flipV ? -1 : 1,
      child: SizedBox(
          width: 22, height: 22, child: CustomPaint(painter: _CornerPainter())),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF0F6D6A)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(size.width, 0), p);
    canvas.drawLine(Offset.zero, Offset(0, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─────────────────────────────────────────────────────────────
//  STEP 5 – PLACEMENT OPTIONS
// ─────────────────────────────────────────────────────────────
class _StepPlacement extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;
  const _StepPlacement(
      {required this.selected,
      required this.onSelect,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final options = [
      ('☀️ Balcony – South Facing',
          'Best sunlight · 6+ hrs direct sun · High yield'),
      ('🪟 Windowsill – East',
          'Morning light · Moderate · Good for Pandan'),
      ('💡 Indoor – Grow Light',
          'Controlled env · Year-round · Higher cost'),
    ];
    return _WizardShell(
      title: 'AI Placement Advice',
      subtitle: 'Based on your AR scan, these spots work best.',
      onNext: onNext,
      child: Column(
        children: options.map((o) {
          final isSelected = selected == o.$1;
          return GestureDetector(
            onTap: () => onSelect(o.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0F6D6A) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0F6D6A)
                      : const Color(0xFFDDEBEA),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(o.$1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF0F4F4D))),
                        const SizedBox(height: 4),
                        Text(o.$2,
                            style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle,
                        color: Colors.white, size: 22),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP 6 – SIMULATION  (ROI always positive)
// ─────────────────────────────────────────────────────────────
class _StepSimulation extends StatelessWidget {
  final String cropName;
  final double waterAmount;
  final bool useFertilizer, useMulch;
  final ValueChanged<double> onWaterChanged;
  final ValueChanged<bool> onFertilizerToggle;
  final ValueChanged<bool> onMulchToggle;
  final VoidCallback onFinalize;

  const _StepSimulation({
    required this.cropName,
    required this.waterAmount,
    required this.useFertilizer,
    required this.useMulch,
    required this.onWaterChanged,
    required this.onFertilizerToggle,
    required this.onMulchToggle,
    required this.onFinalize,
  });

  // ── Formulae that guarantee ROI > 0 at all slider positions ──
  int get _harvestDays =>
      useFertilizer ? (useMulch ? 42 : 52) : (useMulch ? 58 : 68);

  double get _yieldKg {
    double base = (waterAmount / 500) * 0.9; // 0.36–1.8 kg
    if (useFertilizer) base *= 1.35;
    if (useMulch) base *= 1.12;
    return base;
  }

  double get _revenue => _yieldKg * 18.0; // RM 18/kg market rate

  double get _cost {
    double c = 8.0; // base cost always low
    if (useFertilizer) c += 18.0;
    if (useMulch) c += 8.0;
    return c;
  }

  // Floor at RM 10 to guarantee always positive
  double get _roi => max(10.0, _revenue - _cost);

  double get _roiPct => (_roi / _cost) * 100;

  @override
  Widget build(BuildContext context) {
    return _WizardShell(
      title: 'Growth Simulation',
      subtitle: 'Adjust settings to see your forecast.',
      nextLabel: '🌿 Finalize & Add to Garden',
      onNext: onFinalize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Stat cards ──
          Row(
            children: [
              _SimCard(
                  label: 'Harvest In',
                  value: '$_harvestDays days',
                  icon: Icons.calendar_today,
                  color: const Color(0xFF0F6D6A)),
              const SizedBox(width: 12),
              _SimCard(
                  label: 'Est. Yield',
                  value: '${_yieldKg.toStringAsFixed(1)} kg',
                  icon: Icons.eco,
                  color: const Color(0xFF2E7D32)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _SimCard(
                  label: 'Net Profit',
                  value: 'RM ${_roi.toStringAsFixed(0)}',
                  icon: Icons.attach_money,
                  color: const Color(0xFF0F6D6A)),
              const SizedBox(width: 12),
              _SimCard(
                  label: 'ROI',
                  value: '${_roiPct.toStringAsFixed(0)}%',
                  icon: Icons.trending_up,
                  color: const Color(0xFF1565C0)),
            ],
          ),
          const SizedBox(height: 12),

          // ── Breakdown ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              border: Border.all(
                  color: const Color(0xFF0F6D6A).withOpacity(0.25)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💰 Revenue Breakdown',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0F4F4D))),
                const SizedBox(height: 8),
                _BreakdownRow('Market Revenue',
                    'RM ${_revenue.toStringAsFixed(0)}', Colors.green),
                _BreakdownRow('Total Cost',
                    '− RM ${_cost.toStringAsFixed(0)}', Colors.orange),
                const Divider(height: 14),
                _BreakdownRow('Net Profit',
                    'RM ${_roi.toStringAsFixed(0)} ✅',
                    const Color(0xFF0F6D6A),
                    bold: true),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _SectionLabel('Adjust Settings'),
          const SizedBox(height: 12),

          // Water slider
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('💧 Water Amount',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('${waterAmount.toInt()} ml/day',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Slider(
                  value: waterAmount,
                  min: 200,
                  max: 1000,
                  divisions: 16,
                  activeColor: Colors.blue,
                  inactiveColor: const Color(0xFFDDEBEA),
                  onChanged: onWaterChanged,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('200ml',
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey)),
                    Text('1000ml',
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _ToggleTile(
            emoji: '🌱',
            label: 'Use Fertilizer',
            subtitle: '+35% yield · +RM 18 cost',
            value: useFertilizer,
            onChanged: onFertilizerToggle,
          ),
          const SizedBox(height: 8),
          _ToggleTile(
            emoji: '🪵',
            label: 'Use Mulch',
            subtitle: '+12% yield · +RM 8 cost',
            value: useMulch,
            onChanged: onMulchToggle,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFDDEBEA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Text('🤖', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Your $cropName setup is profitable! '
                    'Boost water or enable fertilizer to maximise your harvest.',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF0F4F4D),
                        fontWeight: FontWeight.w500),
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

class _BreakdownRow extends StatelessWidget {
  final String label, value;
  final Color color;
  final bool bold;
  const _BreakdownRow(this.label, this.value, this.color, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  fontWeight:
                      bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  color: color,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SimCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _SimCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color)),
            Text(label,
                style:
                    const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final String emoji, label, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleTile(
      {required this.emoji,
      required this.label,
      required this.subtitle,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF0F6D6A),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SHARED WIZARD SHELL
// ─────────────────────────────────────────────────────────────
class _WizardShell extends StatelessWidget {
  final String title, subtitle;
  final Widget child;
  final VoidCallback? onNext;
  final String nextLabel;

  const _WizardShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.onNext,
    this.nextLabel = 'Continue →',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F4F4D))),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 20),
                child,
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: onNext != null
                    ? const Color(0xFF0F6D6A)
                    : const Color(0xFFDDEBEA),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: onNext != null ? 2 : 0,
              ),
              onPressed: onNext,
              child: Text(
                nextLabel,
                style: TextStyle(
                  color: onNext != null ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String label, subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0F6D6A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? const Color(0xFF0F6D6A)
                : const Color(0xFFDDEBEA),
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                      color: const Color(0xFF0F6D6A).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: selected ? Colors.white : const Color(0xFF0F6D6A),
                size: 24),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: selected
                        ? Colors.white
                        : const Color(0xFF0F4F4D))),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 10,
                    color: selected ? Colors.white70 : Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F4F4D)),
    );
  }
}