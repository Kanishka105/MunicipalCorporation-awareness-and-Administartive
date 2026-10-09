import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 18),
          ),
        ),
        title: Row(
          children: const [
            Text('CleanCity ', style: TextStyle(fontWeight: FontWeight.w900)),
            Text('• Feed', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryTeal)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildFilterChip('Explore All', Icons.explore, true),
                const SizedBox(width: 8),
                _buildFilterChip('Nearby (<5km)', Icons.near_me_outlined, false),
                const SizedBox(width: 8),
                _buildFilterChip('Top Upvoted', Icons.local_fire_department_outlined, false),
              ],
            ),
          ),
          
          // GPS Status Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primaryTeal, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('GNSS LOCK', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal)),
                    const Text(' • ', style: TextStyle(fontSize: 9, color: AppTheme.textLight)),
                    const Icon(Icons.satellite_alt, size: 10, color: AppTheme.textLight),
                    const SizedBox(width: 4),
                    const Text('9 SATELLITES', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                  ],
                ),
                const Text('ACCURACY ±2.4m', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Feed
          Expanded(
            child: ListView(
              children: [
                _buildPostCard(
                  context,
                  userName: 'Elena Rostova',
                  timeAgo: '2 hours ago',
                  cameraInfo: 'Olympus OM-1',
                  locationName: 'Mt. Rainier Trail',
                  coords: '46.8523° N, 121.7603° W',
                  elevation: '2,148m',
                  imageUrl: 'https://images.unsplash.com/photo-1605281317010-fe5ffe798166?auto=format&fit=crop&w=800&q=80',
                  title: 'Sunrise over Emerald Ridge',
                  desc: 'Caught the first golden hour rays after a 4am hike. The fog cleared right at 06:14 AM.',
                  upvotes: '342 Upvotes',
                  comments: '48',
                  hasPro: true,
                ),
                _buildPostCard(
                  context,
                  userName: 'Marcus Chen',
                  timeAgo: '5 hours ago',
                  cameraInfo: 'Sony A7IV 14mm',
                  locationName: 'Embarcadero Bay Bridge',
                  coords: '37.7749° N, 122.4194° W',
                  elevation: '15s exp',
                  imageUrl: 'https://images.unsplash.com/photo-1542314831-c6a4d1421045?auto=format&fit=crop&w=800&q=80',
                  title: 'Urban Geometry & Reflections',
                  desc: 'Long exposure test with the new wide lens on the pedestrian bridge.',
                  upvotes: '128 Upvotes',
                  comments: '19',
                  hasPro: true,
                  isElevationDark: true,
                ),
                const SizedBox(height: 80), // Padding for FAB
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryTeal : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isSelected ? Colors.white : AppTheme.textDark),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppTheme.textDark,
          )),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, {
    required String userName, required String timeAgo, required String cameraInfo,
    required String locationName, required String coords, required String elevation,
    required String imageUrl, required String title, required String desc,
    required String upvotes, required String comments, required bool hasPro,
    bool isElevationDark = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
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
                          Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          if (hasPro) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                              child: const Text('PRO', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.blue)),
                            )
                          ]
                        ],
                      ),
                      Text('$timeAgo • $cameraInfo', style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.more_horiz, color: AppTheme.textLight), onPressed: () {}),
              ],
            ),
          ),
          
          // Image with Overlays
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/grievance_detail');
            },
            child: Stack(
              children: [
                Container(
                  width: double.infinity, 
                  height: 350, 
                  color: Colors.blueGrey[100],
                  child: const Center(child: Icon(Icons.landscape, size: 60, color: Colors.white)),
                ),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppTheme.primaryTeal),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(locationName, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            Text(coords, style: const TextStyle(fontSize: 8, color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isElevationDark ? Colors.black.withOpacity(0.6) : Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.landscape, size: 10, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(elevation, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const SizedBox(height: 6),
                Text(desc, style: const TextStyle(fontSize: 13, color: AppTheme.textLight, height: 1.4)),
                const SizedBox(height: 16),
                
                // Bottom Actions
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryTeal,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_upward, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(upvotes, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.chat_bubble_outline, size: 16, color: AppTheme.textDark),
                          const SizedBox(width: 6),
                          Text(comments, style: const TextStyle(color: AppTheme.textDark, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: AppTheme.background, shape: BoxShape.circle),
                      child: const Icon(Icons.share_outlined, size: 16, color: AppTheme.textDark),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: AppTheme.background, shape: BoxShape.circle),
                      child: const Icon(Icons.bookmark_border, size: 16, color: AppTheme.textDark),
                    ),
                  ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
