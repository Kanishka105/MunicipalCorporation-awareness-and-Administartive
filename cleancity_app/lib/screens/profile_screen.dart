import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            const Text('CleanCity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(width: 4),
            Text('• Profile', style: TextStyle(color: AppTheme.textSecondary, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/62.jpg'),
              radius: 16,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.near_me_outlined, size: 14, color: AppTheme.primaryColor),
                const SizedBox(width: 4),
                Text('GPS LIVE', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Card
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.cyan.withOpacity(0.1),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/62.jpg'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle),
                            child: const Icon(Icons.verified, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Julian Vance', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('@julian.vance@cleancity.io', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                    const SizedBox(height: 24),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.accentBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('24', 'Posts'),
                          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
                          _buildStatColumn('1.8k', 'Upvotes'),
                          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
                          _buildStatColumn('12', 'Mapped'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context); // Go back to login for demo
                            },
                            icon: const Icon(Icons.logout, color: Colors.red),
                            label: const Text('Log Out', style: TextStyle(color: Colors.red)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.1),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Grid Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('My Captures', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('Field telemetry & spatial snaps', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: const [
                              Icon(Icons.grid_view, size: 14, color: AppTheme.primaryColor),
                              SizedBox(width: 4),
                              Text('Grid', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Icon(Icons.view_list, size: 14, color: AppTheme.textSecondary),
                              const SizedBox(width: 4),
                              Text('List', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Info Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentBlue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app_outlined, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tap any photo to view full location data, edit details, or delete post.',
                      style: TextStyle(color: AppTheme.textPrimary, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Grid
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final imgs = [
                  'https://images.unsplash.com/photo-1542401886-65d6c61db217?w=400',
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
                  'https://images.unsplash.com/photo-1448375240586-882707db888b?w=400',
                  'https://images.unsplash.com/photo-1511497584788-876760111969?w=400',
                  'https://images.unsplash.com/photo-1531366936337-7c912a458b07?w=400',
                  'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=400',
                ];
                final coords = ['46.85° N', null, null, null, null, null];
                final badges = [
                  {'icon': Icons.arrow_upward, 'text': '342', 'color': Colors.redAccent},
                  {'icon': Icons.arrow_upward, 'text': '189', 'color': Colors.black54},
                  {'icon': Icons.arrow_upward, 'text': '94', 'color': Colors.black54},
                  {'icon': Icons.arrow_upward, 'text': '215', 'color': Colors.black54},
                  {'icon': Icons.arrow_upward, 'text': '512', 'color': Colors.redAccent},
                  {'icon': Icons.arrow_upward, 'text': '88', 'color': Colors.black54},
                ];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(imgs[index], fit: BoxFit.cover),
                      if (coords[index] != null)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                            child: Text(coords[index]!, style: const TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: badges[index]['color'] as Color, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(badges[index]['icon'] as IconData, color: Colors.white, size: 10),
                              const SizedBox(width: 2),
                              Text(badges[index]['text'] as String, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
      ],
    );
  }
}
