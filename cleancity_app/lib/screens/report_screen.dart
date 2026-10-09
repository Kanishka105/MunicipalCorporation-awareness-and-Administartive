import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isTakePhoto = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.location_on, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 8),
            const Text('Create'),
          ],
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isTakePhoto = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isTakePhoto ? AppTheme.primaryTeal : AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, color: isTakePhoto ? Colors.white : AppTheme.primaryTeal, size: 18),
                          const SizedBox(width: 8),
                          Text('Take Photo', style: TextStyle(color: isTakePhoto ? Colors.white : AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isTakePhoto = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isTakePhoto ? AppTheme.primaryTeal : AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_library_outlined, color: !isTakePhoto ? Colors.white : AppTheme.primaryTeal, size: 18),
                          const SizedBox(width: 8),
                          Text('From Gallery', style: TextStyle(color: !isTakePhoto ? Colors.white : AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Image Preview
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.landscape, size: 60, color: Colors.white)),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Row(
                      children: [
                        _buildImageActionChip(Icons.replay, 'Retake'),
                        const SizedBox(width: 8),
                        _buildImageActionChip(Icons.swap_horiz, 'Replace'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 16, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.camera, color: Colors.white, size: 12),
                          SizedBox(width: 6),
                          Text('24mm • f/2.8 • ISO 100', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // GPS Module
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppTheme.primaryTeal, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          const Text('GPS Coordinates\nDetected', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.2)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.primaryLight, borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: const [
                            Icon(Icons.satellite_alt, size: 12, color: AppTheme.primaryTeal),
                            SizedBox(width: 4),
                            Text('High Accuracy •\n±3m', style: TextStyle(fontSize: 9, color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildCoordinateBox('Latitude', '36.6002° N', Icons.arrow_upward)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildCoordinateBox('Longitude', '121.8947° W', Icons.arrow_back)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppTheme.primaryLight, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: AppTheme.primaryTeal, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Tagged Geographic Location', style: TextStyle(fontSize: 10, color: AppTheme.textDark)),
                              Text('Monterey Coast Highway 1, California', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.refresh, size: 12, color: AppTheme.primaryTeal),
                          SizedBox(width: 4),
                          Text('Recalibrate GPS Fix', style: TextStyle(fontSize: 10, color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text('Sats: 14 locked', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.verified_user_outlined, size: 14, color: AppTheme.textLight),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text('Accurate hardware GPS coordinates will be permanently tagged to this photo.', style: TextStyle(fontSize: 10, color: AppTheme.textDark)),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Map Preview
            Container(
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green[100], 
              ),
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: const LatLng(36.6002, -121.8947),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png?api_key=cb1_4feh_1_87be5a2ae82834121d08d596',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      const MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(36.6002, -121.8947),
                            width: 30,
                            height: 30,
                            child: Icon(Icons.location_on, color: AppTheme.primaryTeal, size: 30),
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: const [
                          Icon(Icons.gps_fixed, size: 10, color: AppTheme.primaryTeal),
                          SizedBox(width: 4),
                          Text('Map Pin Synced', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Form Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('0 / 60', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'e.g. Sunset Cliffs Pacific Overlook',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Story & Trail Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Optional', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Add thoughts, camera settings, or trail notes...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTagChip('#Coastal', isBlue: true),
                _buildTagChip('#Overlook', isBlue: true),
                _buildTagChip('#GoldenHour', isBlue: true),
                _buildTagChip('+ Add Tag', isBlue: false),
              ],
            ),
            const SizedBox(height: 32),
            
            // Submit Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 54)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.send_outlined, size: 18),
                  SizedBox(width: 8),
                  Text('Publish Post to Feed'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.verified, size: 14, color: AppTheme.primaryTeal),
                SizedBox(width: 6),
                Text('Tagged with verified GPS • Visible to community', style: TextStyle(fontSize: 10, color: AppTheme.textDark)),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildImageActionChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppTheme.primaryTeal),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _buildCoordinateBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 10, color: AppTheme.textLight),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textDark)),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, {required bool isBlue}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isBlue ? Colors.blue[50] : AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isBlue ? Colors.blue[800] : AppTheme.primaryTeal,
        ),
      ),
    );
  }
}
