import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../theme.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Post> _dummyPosts = [
    Post(
      id: '1',
      authorName: 'Elena Rostova',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      timeAgo: '2 hours ago',
      cameraInfo: 'Olympus OM-1',
      latitude: 46.8523,
      longitude: 121.7603,
      elevation: '2,140m',
      locationName: 'Mt. Rainier Trail',
      imageUrl: 'https://images.unsplash.com/photo-1542401886-65d6c61db217?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      title: 'Sunrise over Emerald Ridge',
      description: 'Caught the first golden hour rays after a 4am hike. The fog cleared right at 06:14 AM.',
      upvotes: 342,
      comments: 48,
    ),
    Post(
      id: '2',
      authorName: 'Marcus Chen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      timeAgo: '5 hours ago',
      cameraInfo: 'Sony A7IV 14mm',
      latitude: 37.7749,
      longitude: 122.4194,
      elevation: '15s exp',
      locationName: 'Embarcadero Bay Bridge',
      imageUrl: 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      title: 'Urban Geometry & Reflections',
      description: 'Long exposure test with the new wide lens on the pedestrian bridge.',
      upvotes: 128,
      comments: 19,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.location_on, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'CleanCity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 4),
            Text(
              '• Feed',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/62.jpg'),
              radius: 16,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'GPS LIVE',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text('GNSS LOCK • 9 SATELLITES', style: TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text('ACCURACY ±2.4m', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _dummyPosts.length + 1,
        itemBuilder: (context, index) {
          if (index == _dummyPosts.length) {
            return _buildFooterCard();
          }
          return PostCard(post: _dummyPosts[index]);
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : AppTheme.textPrimary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterCard() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.radar, color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 16),
          const Text(
            "You're up to date in this sector",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "Expand your search perimeter or drop\nyour own geotagged snapshot to enrich\nthe cartography.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
