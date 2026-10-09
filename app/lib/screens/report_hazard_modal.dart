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
  String _selectedCategory = 'Overflowing Municipal Bins';
  String _locationText = 'DTU North Gate, Sector 17 Rohini (28.7499° N, 77.1172° E)';
  bool _isNearSensitiveZone = true;
  bool _isAiScanning = false;
  Map<String, dynamic>? _submissionResult;

  final List<String> _categories = [
    'Overflowing Municipal Bins',
    'Open Garbage Dumps & Litter',
    'Waste Burning & Smoke Detection',
    'Stormwater Drain Silt & Blockage',
    'Construction & Demolition Debris',
    'Cracked Manhole / Road Cave-in',
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
        : 'Reported Civic Hazard - ${_selectedCategory.split(' & ').first}';
    final desc = _descController.text.trim().isNotEmpty
        ? _descController.text.trim()
        : 'Live camera EXIF telemetry recorded. Proximity to Dr. BSA Hospital approach zone.';

    setState(() {
      _isAiScanning = true;
    });

    await Future.delayed(const Duration(milliseconds: 1100));

    if (mounted) {
      final state = context.read<CivicAppState>();
      final result = await state.submitNewHazardReport(
        title: title,
        description: desc,
        category: _selectedCategory,
        locationTag: _locationText.split(' (').first,
        isNearHospitalOrSchool: _isNearSensitiveZone,
      );

      setState(() {
        _isAiScanning = false;
        _submissionResult = result;
      });

      await Future.delayed(const Duration(milliseconds: 1600));
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CivicColors.mintDark,
            content: Text(result['message'] as String),
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
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: _submissionResult != null
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
                    _submissionResult!['isDuplicateMerged'] == true
                        ? 'Proximity Duplicate Merged'
                        : 'Live Report Dispatched',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _submissionResult!['message'] as String,
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
                          child: const Icon(Icons.videocam, color: CivicColors.primary, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Live-Camera Citizen Report',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              'EXIF Signed • Gallery Upload Blocked',
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
                const SizedBox(height: 4),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Live-camera Viewfinder
                        Container(
                          height: 170,
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
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: CivicColors.urgentRed,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    '• LIVE CAMERA SENSOR ONLY',
                                    style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.lock, color: CivicColors.mint, size: 14),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'EXIF pHash Lock (28.7499, 77.1172) • Gallery Blocked',
                                          style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Sensitive Zone Booster
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark ? CivicColors.borderDark : const Color(0xFFDCFCE7),
                            ),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isNearSensitiveZone,
                                activeColor: CivicColors.primary,
                                onChanged: (val) {
                                  if (val != null) setState(() => _isNearSensitiveZone = val);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Near Hospital / School / Water Body',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'Boosts AI Severity Score (+20 pts) for urgent priority triage.',
                                      style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white60 : Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Category Dropdown
                        Text(
                          'AI Detected Hazard Category',
                          style: TextStyle(
                            fontSize: 12.5,
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
                                      fontSize: 12.5,
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
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          'Landmark / Proximity Tag',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _titleController,
                          style: TextStyle(color: isDark ? Colors.white : CivicColors.textPrimaryLight, fontSize: 13.5),
                          decoration: InputDecoration(
                            hintText: 'e.g. DTU North Gate / Metro Pillar 24',
                            filled: true,
                            fillColor: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          'Observations & Public Risk Notes',
                          style: TextStyle(
                            fontSize: 12.5,
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
                            hintText: 'Describe public blockage, odor, or safety hazard...',
                            filled: true,
                            fillColor: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                              Text('Running Duplicate Merge Check & pHash EXIF...'),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send_rounded, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Dispatch Live Report (+25 KP)',
                                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
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
