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

  void _showCareRemindersDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const _CareRemindersDialog(),
    );
  }

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
                    onPressed: () => _showCareRemindersDialog(context),
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

// ---------------------------------------------------------------------------
// Care Reminders Dialog
// ---------------------------------------------------------------------------

class _CareRemindersDialog extends StatefulWidget {
  const _CareRemindersDialog();

  @override
  State<_CareRemindersDialog> createState() => _CareRemindersDialogState();
}

class _CareRemindersDialogState extends State<_CareRemindersDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _reminderType = 'Watering';
  bool _isSyncing = false;
  bool _syncDone = false;

  final List<String> _reminderTypes = [
    'Watering',
    'Fertilizing',
    'Pruning',
    'Repotting',
    'Pest Check',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F6D6A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF0F4F4D),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F6D6A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF0F4F4D),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} / '
      '${d.month.toString().padLeft(2, '0')} / '
      '${d.year}';

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _handleGoogleSync() async {
    setState(() {
      _isSyncing = true;
      _syncDone = false;
    });
    // Simulate async sync
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSyncing = false;
      _syncDone = true;
    });
  }

  void _saveReminder() {
    // TODO: wire up to your reminder/notification logic
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Care reminder saved!'),
        backgroundColor: Color(0xFF0F6D6A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined,
                      color: Color(0xFF0F6D6A), size: 26),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Set Care Reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F4F4D),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Configure your plant care schedule below.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 24),

              // ── Google Calendar Sync ────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF4F3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFB2D8D6)),
                ),
                child: Row(
                  children: [
                    // Google calendar colourful icon simulation
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.calendar_today,
                          color: Color(0xFF4285F4), size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Google Calendar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF0F4F4D),
                            ),
                          ),
                          Text(
                            _syncDone
                                ? 'Synced successfully ✓'
                                : 'Sync reminder to your calendar',
                            style: TextStyle(
                              fontSize: 12,
                              color: _syncDone
                                  ? const Color(0xFF0F6D6A)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: _isSyncing || _syncDone
                            ? null
                            : _handleGoogleSync,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _syncDone
                              ? const Color(0xFF0F6D6A)
                              : const Color(0xFF4285F4),
                          disabledBackgroundColor: _syncDone
                              ? const Color(0xFF0F6D6A)
                              : Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                        ),
                        child: _isSyncing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _syncDone ? 'Synced' : 'Sync',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Reminder Type ───────────────────────────────────────────
              const _FieldLabel(text: 'Reminder Type'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF4F3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFB2D8D6)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _reminderType,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF0F6D6A)),
                    style: const TextStyle(
                      color: Color(0xFF0F4F4D),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    items: _reminderTypes
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(t),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _reminderType = v);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Task Title ──────────────────────────────────────────────
              const _FieldLabel(text: 'Task Title'),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                style: const TextStyle(
                    color: Color(0xFF0F4F4D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                decoration: _inputDecoration('e.g. Water tomato plant'),
              ),

              const SizedBox(height: 16),

              // ── Date & Time Row ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel(text: 'Date'),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF4F3),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFFB2D8D6)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    color: Color(0xFF0F6D6A), size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedDate != null
                                        ? _formatDate(_selectedDate!)
                                        : 'Pick date',
                                    style: TextStyle(
                                      color: _selectedDate != null
                                          ? const Color(0xFF0F4F4D)
                                          : Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel(text: 'Time'),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _pickTime,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF4F3),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFFB2D8D6)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time_outlined,
                                    color: Color(0xFF0F6D6A), size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedTime != null
                                        ? _formatTime(_selectedTime!)
                                        : 'Pick time',
                                    style: TextStyle(
                                      color: _selectedTime != null
                                          ? const Color(0xFF0F4F4D)
                                          : Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Task Details / Notes ────────────────────────────────────
              const _FieldLabel(text: 'Task Details'),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 3,
                style: const TextStyle(
                    color: Color(0xFF0F4F4D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                decoration: _inputDecoration(
                  'Add any additional notes or instructions…',
                ),
              ),

              const SizedBox(height: 28),

              // ── Action Buttons ──────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF0F6D6A)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF0F6D6A),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveReminder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F6D6A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save Reminder',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFEBF4F3),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB2D8D6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB2D8D6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Color(0xFF0F6D6A), width: 1.8),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared small widgets
// ---------------------------------------------------------------------------

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F6D6A),
        letterSpacing: 0.4,
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