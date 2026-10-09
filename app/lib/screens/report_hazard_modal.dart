import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

class ReportHazardModal extends StatefulWidget {
  const ReportHazardModal({super.key});

  @override
  State<ReportHazardModal> createState() => _ReportHazardModalState();
}

class _ReportHazardModalState extends State<ReportHazardModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Solid Waste / Garbage Overflow';
  final String _locationText = 'DTU North Gate, Sector 17 Rohini (28.7499° N, 77.1172° E)';
  bool _isAiScanning = false;
  bool _isSubmitted = false;

  final List<String> _categories = [
    'Solid Waste / Garbage Overflow',
    'Stormwater Drain Silt & Plastic Clogging',
    'Cracked Manhole / Road Cave-in',
    'Broken Streetlight / Ballast Failure',
    'Pot-hole / Road Surface Debris',
    'Water Pipe Leakage / Contamination',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitReport() async {
    final title = _titleController.text.trim().isNotEmpty
        ? _titleController.text.trim()
        : 'Reported Civic Hazard - ${_selectedCategory.split(' / ').first}';
    final desc = _descController.text.trim().isNotEmpty
        ? _descController.text.trim()
        : 'Immediate municipal attention requested. AI pre-signed EXIF telemetry recorded.';

    setState(() {
      _isAiScanning = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      final state = context.read<CivicAppState>();
      await state.submitNewHazardReport(
        title: title,
        description: desc,
        category: _selectedCategory.split(' / ').first,
        locationTag: _locationText.split(' (').first,
      );

      setState(() {
        _isAiScanning = false;
        _isSubmitted = true;
      });

      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CivicColors.mintDark,
            content: const Text('🎉 Hazard reported successfully! +25 Karma Points added.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: _isSubmitted
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: CivicColors.mintBadgeBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: CivicColors.mintDark, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ticket Dispatched & Encrypted',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'AI Rekognition Dedup Passed (96.8% Confidence)\nAssigned to Ward 42 PWD Sanitation Squad.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modal Handle bar
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CivicColors.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera_alt, color: CivicColors.primary, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Report Civic Hazard',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              'AI Auto-Triage • Auto-GPS & S3 Pre-signed',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Simulated Camera Live Viewfinder
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1605600659908-0ef719419d41?auto=format&fit=crop&w=800&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: CivicColors.urgentRed,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    '• LIVE CAMERA SENSOR',
                                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.lock, color: CivicColors.mint, size: 14),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'GPS EXIF L1/L5 Tamper-Locked (±1.4m)',
                                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Category Dropdown
                        Text(
                          'Hazard Category',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              dropdownColor: isDark ? CivicColors.cardDark : Colors.white,
                              items: _categories.map((c) {
                                return DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedCategory = val);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Title
                        Text(
                          'Short Title / Landmark',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _titleController,
                          style: TextStyle(color: isDark ? Colors.white : CivicColors.textPrimaryLight, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'e.g. Broken pavement near Metro Gate 2',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                            ),
                            filled: true,
                            fillColor: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Description
                        Text(
                          'Observations & Severity Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _descController,
                          maxLines: 2,
                          style: TextStyle(color: isDark ? Colors.white : CivicColors.textPrimaryLight, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Describe obstruction or safety risk to pedestrians...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                            ),
                            filled: true,
                            fillColor: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CivicColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    onPressed: _isAiScanning ? null : _submitReport,
                    child: _isAiScanning
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              ),
                              SizedBox(width: 10),
                              Text('Running AI Dedup & AWS S3 Upload...'),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send_rounded, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Dispatch Hazard (+25 KP)',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
