import 'package:flutter/material.dart';
import '../theme.dart';

class GrievanceDetailScreen extends StatelessWidget {
  const GrievanceDetailScreen({Key? key}) : super(key: key);

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
            const Text('Post Detail'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 24, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryTeal,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Julian Vance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(4)),
                            child: Text('PRO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal)),
                          )
                        ],
                      ),
                      const Text('Oct 14, 2024 • 17:42 PST', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _buildIconBtn(Icons.edit_outlined),
                    const SizedBox(width: 8),
                    _buildIconBtn(Icons.delete_outline),
                    const SizedBox(width: 8),
                    _buildIconBtn(Icons.share_outlined),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            
            // Image
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blueGrey[100],
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.landscape, size: 60, color: Colors.white)),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primaryTeal, shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          const Text('Big Sur Coast', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          const Text(' ±2.4m', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.landscape, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Text('142m Elev', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt_outlined, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Text('24mm • f/2.8 • 1/320s', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Content
            const Text('Golden Hour Waves at Big Sur', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            const Text(
              'Caught the swell breaking against the granite boulders right before the fog rolled into the canyon. No filter needed.',
              style: TextStyle(fontSize: 15, color: AppTheme.textLight, height: 1.5),
            ),
            const SizedBox(height: 20),
            
            // Upvote Row
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      const Text('Upvoted', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                        child: const Text('215', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    _buildVoterAvatar('EK', Colors.blue),
                    _buildVoterAvatar('ML', Colors.grey),
                    _buildVoterAvatar('+18', AppTheme.primaryTeal, isNumber: true),
                  ],
                ),
                const SizedBox(width: 8),
                const Text('voted this spot', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
              ],
            ),
            const SizedBox(height: 24),
            
            // Spatial Telemetry
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50], // Light blue tint like screenshot
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppTheme.primaryTeal.withOpacity(0.1), shape: BoxShape.circle),
                            child: const Icon(Icons.satellite_alt, color: AppTheme.primaryTeal, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Spatial Telemetry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
                              Text('Big Sur Coastal Reserve, CA', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: const [
                            Icon(Icons.explore, size: 12, color: AppTheme.primaryTeal),
                            SizedBox(width: 4),
                            Text('36°N • 121°W', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Map Box
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green[100],
                    ),
                    child: Stack(
                      children: [
                        const Center(child: Icon(Icons.map, size: 40, color: Colors.green)),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: const [
                                Icon(Icons.landscape, size: 12, color: AppTheme.primaryTeal),
                                SizedBox(width: 4),
                                Text('Elev 142m MSL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildCopyBox('Latitude', '36.2704° N'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCopyBox('Longitude', '121.8081° W'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005670), // Darker blueish button
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.navigation_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('Open in Navigation Maps ↗', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: AppTheme.textDark),
    );
  }

  Widget _buildVoterAvatar(String init, Color color, {bool isNumber = false}) {
    return Align(
      widthFactor: 0.6,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: color.withOpacity(0.5),
        child: Text(init, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isNumber ? Colors.white : Colors.black87)),
      ),
    );
  }

  Widget _buildCopyBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textDark)),
            ],
          ),
          const Icon(Icons.copy, size: 14, color: AppTheme.textLight),
        ],
      ),
    );
  }
}
