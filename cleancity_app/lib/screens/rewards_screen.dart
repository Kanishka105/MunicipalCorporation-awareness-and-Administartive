import 'package:flutter/material.dart';
import '../theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_florist, color: AppTheme.primaryGreen, size: 24),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('CLEANCITY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.primaryGreen)),
                              SizedBox(width: 4),
                              Text('|', style: TextStyle(color: Colors.grey)),
                              SizedBox(width: 4),
                              Text('Rewards', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              const Text('Ward GPS Live', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.primaryGreen, borderRadius: BorderRadius.circular(20)),
                        child: const Text('EN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                        child: const Text('हि', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
                        child: Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 20),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle),
                        child: const Icon(Icons.person_outline, color: Colors.white, size: 20),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Civic Rewards & Trust', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('नागरिक सम्मान एवं विश्वास सूचकांक', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: const [
                        Icon(Icons.verified_user_outlined, size: 12, color: AppTheme.primaryGreen),
                        SizedBox(width: 4),
                        Text('Ward 142', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),

              // Karma Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: const [
                              Icon(Icons.emoji_events, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text('SWACHH KARMA BALANCE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const Text('Active Tier: L4', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('2,450', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text('Karma Pts', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Equivalent to ₹245 utility discount or municipal\ntax rebate voucher.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.card_giftcard, size: 16),
                          SizedBox(width: 8),
                          Text('Redeem Points / रिडीम करें', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Trust Score Area
              const Text('CREDIBILITY INDEX', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Reporter Trust Score:\n98%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.greenAccent[100], borderRadius: BorderRadius.circular(20)),
                    child: const Text('Level 4 Civic\nGuardian', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 0.98,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                        ),
                      ),
                      Column(
                        children: const [
                          Text('98', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('/ 100', style: TextStyle(fontSize: 8, color: AppTheme.textLight)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 14, color: AppTheme.primaryGreen),
                            SizedBox(width: 4),
                            Text('Sample contribution activity', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('Illustrative profile data only; report authenticity and contributor accuracy are not scored.', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.bolt, color: Colors.blue[800], size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Civic Fast-Track Active: ',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                          children: [
                            TextSpan(text: 'Your reports automatically skip manual tier triage and auto-dispatch to BBMP ward crews immediately.', style: TextStyle(fontWeight: FontWeight.normal, color: AppTheme.textLight)),
                          ]
                        )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Earned Badges
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.military_tech, color: AppTheme.warning, size: 20),
                      SizedBox(width: 4),
                      Text('Earned Badges / अर्जित पदक', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text('4 / 6 Unlocked', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                ],
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildBadgeCard(Icons.emoji_events_outlined, 'Gold', 'Spotless Pioneer', 'First 10 sanitation reports cleared within SLA.', Colors.orange[50]!, Colors.orange[800]!),
                  _buildBadgeCard(Icons.security_outlined, 'Hazard', 'Night Watchman', 'Logged 5 critical streetlamp & pothole hazards.', Colors.blue[50]!, Colors.blue[800]!),
                  _buildBadgeCard(Icons.eco_outlined, 'Ward 142', 'Zero Litter Champion', 'Facilitated block black-spot remediation.', Colors.green[50]!, AppTheme.primaryGreen),
                  _buildBadgeCard(Icons.speed, 'Speed', 'Fast Responder', 'Verified civic fixes in under 15 minutes.', Colors.orange[50]!, Colors.orange[800]!),
                ],
              ),
              const SizedBox(height: 24),

              // Leaderboard
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ward 142 Society Leaderboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('वार्ड 142 सोसायटी लीडरबोर्ड • This Month', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.leaderboard, size: 14, color: AppTheme.primaryGreen),
                      SizedBox(width: 4),
                      Text('Top 5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              
              _buildLeaderboardItem(1, 'Indiranagar 2nd Stage RWA', '420 Active Residents', '14,820', true),
              _buildLeaderboardItem(2, 'Def Col Residents Assoc', '310 Active Residents', '12,400', false),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppTheme.primaryGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle),
                      child: const Center(child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('Priya Sharma (You)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppTheme.primaryGreen, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Citizen', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          const Text('32 Verified Ward Actions', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('2,450', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                        Text('pts', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                      ],
                    )
                  ],
                ),
              ),
              _buildLeaderboardItem(4, 'Metro Greens Society', '88 Active Residents', '2,190', false),
              _buildLeaderboardItem(5, 'BDA Complex Residents', '64 Active Residents', '1,850', false),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeCard(IconData icon, String tag, String title, String subtitle, Color bg, Color iconCol) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, color: iconCol, size: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                child: Text(tag, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: iconCol)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String subtitle, String points, bool isTop) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: isTop ? Colors.orange[100] : Colors.grey[200], shape: BoxShape.circle),
            child: Center(child: Text('$rank', style: TextStyle(color: isTop ? Colors.orange[800] : Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    if (isTop) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: AppTheme.warning, size: 12),
                    ]
                  ],
                ),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(points, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const Text('pts', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
            ],
          )
        ],
      ),
    );
  }
}
