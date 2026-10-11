import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../theme.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isSubmitting = false;
  bool _isLocating = false;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  double _latitude = 19.0760;
  double _longitude = 72.8777;
  double _accuracy = 3.2;
  String _selectedCategory = 'waste';
  final List<String> _categories = ['waste', 'water', 'drainage', 'road', 'safety', 'air'];

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() => _isLocating = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 10),
          ),
        );
        if (mounted) {
          setState(() {
            _latitude = position.latitude;
            _longitude = position.longitude;
            _accuracy = position.accuracy;
          });
        }
      }
    } catch (_) {
      // Keep existing default or last coordinates
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1920,
    );
    if (pickedFile != null && mounted) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final latDir = _latitude >= 0 ? 'N' : 'S';
    final lonDir = _longitude >= 0 ? 'E' : 'W';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.location_on, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            const Text('New Spatial Capture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top buttons for camera / gallery
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined, color: AppTheme.textPrimary),
                    label: const Text('From Gallery', style: TextStyle(color: AppTheme.textPrimary)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentBlue,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Image Preview
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (_imageFile == null)
                    GestureDetector(
                      onTap: () => _pickImage(ImageSource.gallery),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[300]!, strokeAlign: BorderSide.strokeAlignInside),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_a_photo_outlined, size: 48, color: AppTheme.primaryColor),
                              SizedBox(height: 8),
                              Text('Tap to capture or select evidence photo', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
                              Text('Photo will be saved securely to AWS S3', style: TextStyle(color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: kIsWeb
                              ? Image.network(
                                  _imageFile!.path,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  io.File(_imageFile!.path),
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery),
                            child: _buildOverlayBtn(Icons.swap_horiz, 'Replace'),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => setState(() => _imageFile = null),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.close, size: 16, color: Colors.red),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text('AWS S3 Ready • AES256', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // GPS Coordinates Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accentBlue.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.circle, size: 10, color: AppTheme.primaryColor),
                          SizedBox(width: 8),
                          Text('Hardware GNSS Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.satellite_alt, size: 12, color: AppTheme.primaryColor),
                            const SizedBox(width: 4),
                            Text('±${_accuracy.toStringAsFixed(1)}m Acc', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Latitude (lat)', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('${_latitude.abs().toStringAsFixed(6)}° $latDir', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Longitude (long)', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('${_longitude.abs().toStringAsFixed(6)}° $lonDir', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _isLocating ? null : _fetchCurrentLocation,
                        child: Row(
                          children: [
                            Icon(Icons.refresh, size: 14, color: _isLocating ? Colors.grey : AppTheme.primaryColor),
                            const SizedBox(width: 4),
                            Text(
                              _isLocating ? 'Acquiring GPS Fix...' : 'Recalibrate GPS Fix',
                              style: TextStyle(color: _isLocating ? Colors.grey : AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Text('Saved in S3 metadata', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Category Selector
            const Text('Issue Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!),
                      ),
                      child: Text(
                        cat.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title Input
            const Text('Report Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'e.g. Garbage accumulation near Central Ward',
                  hintStyle: TextStyle(color: AppTheme.textSecondary.withValues(alpha: 0.7)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Description Input
            const Text('Description & Location Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe the civic issue, landmark details, or severity level...',
                  hintStyle: TextStyle(color: AppTheme.textSecondary.withValues(alpha: 0.7)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Publish button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);

                        final token = await _apiService.getToken();
                        if (token == null) {
                          if (!mounted) return;
                          messenger.showSnackBar(
                            SnackBar(
                              content: const Text('Please sign in with Cognito to publish posts'),
                              action: SnackBarAction(
                                label: 'Sign In',
                                onPressed: () {
                                  navigator.push(
                                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                                  );
                                },
                              ),
                            ),
                          );
                          return;
                        }

                        final title = _titleController.text.trim();
                        final desc = _descController.text.trim();

                        if (title.isEmpty) {
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Please enter an issue title')),
                          );
                          return;
                        }

                        if (_imageFile == null) {
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Please capture or select an evidence photo')),
                          );
                          return;
                        }

                        setState(() => _isSubmitting = true);

                        // 1. Read image bytes & upload to AWS S3
                        final bytes = await _imageFile!.readAsBytes();
                        final photoUrl = await _apiService.uploadEvidenceBytes(
                          bytes,
                          _imageFile!.name.isNotEmpty ? _imageFile!.name : 'evidence.jpg',
                        );

                        if (!mounted) return;

                        if (photoUrl == null) {
                          setState(() => _isSubmitting = false);
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Failed to upload evidence to S3. Please try again.')),
                          );
                          return;
                        }

                        // 2. Create post with coordinates saved in S3
                        final postPayload = {
                          "title": title,
                          "description": desc.isNotEmpty ? desc : "Reported civic issue requiring municipal attention.",
                          "category": _selectedCategory,
                          "gps": {
                            "latitude": _latitude,
                            "longitude": _longitude,
                          },
                          "photo_url": photoUrl,
                          "gps_accuracy_m": _accuracy,
                        };

                        final success = await _apiService.createPost(postPayload);
                        if (!mounted) return;
                        setState(() => _isSubmitting = false);

                        if (success) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.cloud_done, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('Post & GPS location saved to AWS S3!'),
                                ],
                              ),
                              backgroundColor: Color(0xFF16A34A),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          _titleController.clear();
                          _descController.clear();
                          setState(() {
                            _imageFile = null;
                          });
                        } else {
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Failed to publish post. Check backend connection.')),
                          );
                        }
                      },
                icon: _isSubmitting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_upload_outlined),
                label: Text(_isSubmitting ? 'Uploading to S3 & Publishing...' : 'Publish Post to S3 & Feed'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.verified_outlined, size: 14, color: AppTheme.primaryColor),
                SizedBox(width: 6),
                Text('GPS lat, long & photo metadata archived directly in AWS S3', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayBtn(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppTheme.textPrimary),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
