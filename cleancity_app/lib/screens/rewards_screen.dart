import 'package:flutter/material.dart';
import '../theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
            Text('• Rewards', style: TextStyle(color: AppTheme.primaryColor, fontSize: 18)),
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
              backgroundColor: AppTheme.primaryColor,
              child: Icon(Icons.person, color: Colors.white, size: 20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Telemetry Wallet Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Icon(
                      Icons.radar,
                      size: 200,
                      color: AppTheme.primaryColor.withOpacity(0.03),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TELEMETRY WALLET', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentBlue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.emoji_events_outlined, size: 14, color: AppTheme.primaryColor),
                                SizedBox(width: 4),
                                Text('Pioneer Tier IV', style: TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Text('2,450', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Text('CleanPoints', style: TextStyle(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Next: Master Cartographer', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                          const Text('78% (3,000 pts)', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.78,
                          minHeight: 8,
                          backgroundColor: AppTheme.accentBlue.withOpacity(0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CURRENT: 2,450', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, letterSpacing: 1)),
                          Text('550 PTS REMAINING', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.card_giftcard),
                              label: const Text('Redeem Perks'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.receipt_long, color: AppTheme.textPrimary),
                              label: const Text('Ledger History', style: TextStyle(color: AppTheme.textPrimary)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.accentBlue.withOpacity(0.5),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Active Field Quests
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.radar, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 8),
                      Text('Active Field Quests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Text('RESET IN 14H', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            _buildQuestCard(
              icon: Icons.wb_twilight,
              iconColor: Colors.teal,
              title: 'Golden Hour Catch',
              subtitle: 'Geotag 1 sunrise/sunset frame today',
              points: '+150 pts',
              status: 'Claimed',
              isClaimed: true,
            ),
            _buildQuestCard(
              icon: Icons.terrain,
              iconColor: Colors.blue,
              title: 'Unmapped Ridge',
              subtitle: 'Discover and log an uncharted GPS...',
              points: '+300 pts',
              progress: 0.5,
              progressText: '1/2 Sectors',
            ),
            _buildQuestCard(
              icon: Icons.thumb_up_alt_outlined,
              iconColor: Colors.red,
              title: 'Top Spot Pioneer',
              subtitle: 'Receive 50+ upvotes on a coastal l...',
              points: '+500 pts',
              progress: 38/50,
              progressText: '38/50 Upvotes',
              progressColor: Colors.red,
            ),
            const SizedBox(height: 16),
            
            // Field Accreditations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.verified_outlined, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 8),
                      Text('Field Accreditations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Text('3 / 4 ACQUIRED', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildAccreditationCard(Icons.terrain, 'High Altitude', '>2,000m Geotag', true),
                  const SizedBox(width: 12),
                  _buildAccreditationCard(Icons.water, 'Coastline Scout', '5 Pacific Snaps', true),
                  const SizedBox(width: 12),
                  _buildAccreditationCard(Icons.nights_stay_outlined, 'Night Owl', 'Astro Photography', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Gear & Cartography Perks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.storefront_outlined, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 8),
                      Text('Gear & Cartography Perks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Text('Outdoor Tier', style: TextStyle(color: Colors.blue[700], fontSize: 12)),
                ],
              ),
            ),
            _buildPerkCard(
              icon: Icons.verified_user_outlined,
              title: 'Pro Photographer Badge',
              points: '1,500 pts',
              subtitle: 'Distinguished golden badge attached to all live geotagged submissions and explorer profile.',
              footerIcon: Icons.bolt,
              footerText: 'Instant Activation',
              buttonLabel: 'Redeem',
              isRedeemable: true,
            ),
            _buildPerkCard(
              icon: Icons.map_outlined,
              title: 'Offline Topo Maps Pack',
              points: '2,000 pts',
              subtitle: 'High-resolution 1:24,000 USGS and alpine contour vectors cached for offline wilderness expeditions.',
              footerIcon: Icons.download_outlined,
              footerText: '2.4 GB Storage',
              buttonLabel: 'Redeem',
              isRedeemable: true,
            ),
            _buildPerkCard(
              icon: Icons.camera_alt_outlined,
              title: 'Peak Design \$25 Voucher',
              points: '4,000 pts',
              subtitle: 'Digital partner code redeemable for camera straps, clips, or outdoor capture packs.',
              footerIcon: Icons.local_shipping_outlined,
              footerText: 'Hardware credit',
              buttonLabel: 'Locked (61%)',
              isRedeemable: false,
              progress: 2450/4000,
              progressText: '1,550 pts needed',
              progressLabel: 'Progress (2,450 / 4,000)',
            ),
            _buildPerkCard(
              icon: Icons.stars_outlined,
              title: 'Global Explore Feature',
              points: '3,500 pts',
              subtitle: 'Pin your verified geographical photo directly to the hero spotlight for 7 days.',
              footerIcon: Icons.public,
              footerText: '250k+ Views avg.',
              buttonLabel: '1,050 pts away',
              isRedeemable: false,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String points,
    String? status,
    bool isClaimed = false,
    double? progress,
    String? progressText,
    Color progressColor = AppTheme.primaryColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        if (isClaimed) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 14),
                        ]
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(points, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor, fontSize: 12)),
                  if (status != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.accentBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(status, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ]
                ],
              )
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: AppTheme.backgroundColor,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(progressText ?? '', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _buildAccreditationCard(IconData icon, String title, String subtitle, bool unlocked) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: unlocked ? Border.all(color: AppTheme.primaryColor.withOpacity(0.1)) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: unlocked ? AppTheme.primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: unlocked ? AppTheme.primaryColor : Colors.grey, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: unlocked ? AppTheme.textPrimary : Colors.grey)),
          const SizedBox(height: 4),
          Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: unlocked ? AppTheme.textSecondary : Colors.grey, fontSize: 10)),
          const Spacer(),
          if (unlocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA), // Light cyan
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check, size: 10, color: Colors.teal),
                  SizedBox(width: 4),
                  Text('UNLOCKED', style: TextStyle(color: Colors.teal, fontSize: 9, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          else
            const Icon(Icons.lock_outline, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildPerkCard({
    required IconData icon,
    required String title,
    required String points,
    required String subtitle,
    required IconData footerIcon,
    required String footerText,
    required String buttonLabel,
    required bool isRedeemable,
    double? progress,
    String? progressText,
    String? progressLabel,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.textPrimary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                        Text(points, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(subtitle, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(progressLabel ?? '', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                Text(progressText ?? '', style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppTheme.backgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(footerIcon, size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(footerText, style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isRedeemable ? AppTheme.primaryColor : AppTheme.accentBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  buttonLabel,
                  style: TextStyle(
                    color: isRedeemable ? Colors.white : AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
