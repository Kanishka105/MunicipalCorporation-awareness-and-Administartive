import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/api_service.dart';
import '../models/post_model.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final ApiService _apiService = ApiService();
  List<Post> _myPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  Future<void> _loadRewards() async {
    setState(() => _isLoading = true);
    try {
      final posts = await _apiService.getMyPosts();
      if (mounted) {
        setState(() {
          _myPosts = posts;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  int get _totalUpvotes => _myPosts.fold<int>(0, (sum, p) => sum + p.upvotes);
  int get _points => (_myPosts.length * 100) + (_totalUpvotes * 25);
  int get _uniqueCategoriesCount => _myPosts.map((p) => p.category.toLowerCase()).toSet().length;

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
            icon: const Icon(Icons.refresh),
            onPressed: _loadRewards,
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.near_me_outlined, size: 14, color: AppTheme.primaryColor),
                const SizedBox(width: 4),
                Text('GPS LIVE & S3 SYNCED', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRewards,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Telemetry Wallet Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CIVIC IMPACT WALLET', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentBlue.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.emoji_events_outlined, size: 14, color: AppTheme.primaryColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      _myPosts.isNotEmpty ? 'Active Contributor' : 'Novice Scout',
                                      style: const TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
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
                              Text('$_points', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              const Text('CleanPoints', style: TextStyle(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Based on ${_myPosts.length} S3 Posts & $_totalUpvotes Upvotes',
                                style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
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
                              Text('Live Field Quests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                          Text('DYNAMIC MILESTONES', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    _buildQuestCard(
                      icon: Icons.camera_alt,
                      iconColor: Colors.teal,
                      title: 'First S3 Telemetry',
                      subtitle: 'Geotag and save your first post to S3',
                      points: '+100 pts',
                      status: _myPosts.isNotEmpty ? 'Claimed' : '0/1 Completed',
                      isClaimed: _myPosts.isNotEmpty,
                      progress: _myPosts.isNotEmpty ? 1.0 : 0.0,
                      progressText: _myPosts.isNotEmpty ? '1/1 Uploaded' : '0/1 Uploaded',
                    ),
                    _buildQuestCard(
                      icon: Icons.thumb_up_alt_outlined,
                      iconColor: Colors.red,
                      title: 'Community Voice Pioneer',
                      subtitle: 'Receive 5+ upvotes from local citizens',
                      points: '+250 pts',
                      isClaimed: _totalUpvotes >= 5,
                      status: _totalUpvotes >= 5 ? 'Claimed' : 'In Progress',
                      progress: (_totalUpvotes / 5.0).clamp(0.0, 1.0),
                      progressText: '$_totalUpvotes/5 Upvotes',
                      progressColor: Colors.red,
                    ),
                    _buildQuestCard(
                      icon: Icons.category_outlined,
                      iconColor: Colors.blue,
                      title: 'Multi-Sector Observer',
                      subtitle: 'Report issues across 2+ distinct categories',
                      points: '+200 pts',
                      isClaimed: _uniqueCategoriesCount >= 2,
                      status: _uniqueCategoriesCount >= 2 ? 'Claimed' : 'In Progress',
                      progress: (_uniqueCategoriesCount / 2.0).clamp(0.0, 1.0),
                      progressText: '$_uniqueCategoriesCount/2 Sectors',
                    ),
                    _buildQuestCard(
                      icon: Icons.cloud_done_outlined,
                      iconColor: Colors.amber[800] ?? Colors.amber,
                      title: 'Civic Sentinel',
                      subtitle: 'Archive 3+ spatial posts in AWS S3',
                      points: '+400 pts',
                      isClaimed: _myPosts.length >= 3,
                      status: _myPosts.length >= 3 ? 'Claimed' : 'In Progress',
                      progress: (_myPosts.length / 3.0).clamp(0.0, 1.0),
                      progressText: '${_myPosts.length}/3 Reports',
                      progressColor: Colors.amber[800] ?? Colors.amber,
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
                          Text('LIVE ACHIEVEMENTS', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 155,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          _buildAccreditationCard(
                            Icons.cloud_upload_outlined,
                            'S3 Field Pioneer',
                            'First Post in S3',
                            _myPosts.isNotEmpty,
                          ),
                          const SizedBox(width: 12),
                          _buildAccreditationCard(
                            Icons.thumb_up_outlined,
                            'Citizen Endorsed',
                            '1+ Upvotes Received',
                            _totalUpvotes > 0,
                          ),
                          const SizedBox(width: 12),
                          _buildAccreditationCard(
                            Icons.map_outlined,
                            'Civic Surveyor',
                            '3+ S3 Reports Logged',
                            _myPosts.length >= 3,
                          ),
                          const SizedBox(width: 12),
                          _buildAccreditationCard(
                            Icons.explore_outlined,
                            'Multi-Sector Scout',
                            '2+ Sectors Tagged',
                            _uniqueCategoriesCount >= 2,
                          ),
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
                              Text('Civic Honors & Perks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                          Text('CleanPoints Store', style: TextStyle(color: Colors.blue[700], fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    _buildPerkCard(
                      icon: Icons.verified_user_outlined,
                      title: 'Verified Contributor Badge',
                      points: '200 pts',
                      subtitle: 'Distinguished citizen badge attached to all your live geotagged submissions in the S3 feed.',
                      footerIcon: Icons.bolt,
                      footerText: 'Instant Activation',
                      buttonLabel: _points >= 200 ? 'Unlocked' : '${200 - _points} pts needed',
                      isRedeemable: _points >= 200,
                      progress: (_points / 200.0).clamp(0.0, 1.0),
                      progressText: '$_points / 200 pts',
                      progressLabel: 'Status (${_points >= 200 ? "Ready" : "Locked"})',
                    ),
                    _buildPerkCard(
                      icon: Icons.star_outline,
                      title: 'Feed Priority Spotlight',
                      points: '500 pts',
                      subtitle: 'Highlights your reported issues at the top of the community feed for faster municipal resolution.',
                      footerIcon: Icons.trending_up,
                      footerText: 'Municipal Fast-Track',
                      buttonLabel: _points >= 500 ? 'Unlocked' : '${500 - _points} pts needed',
                      isRedeemable: _points >= 500,
                      progress: (_points / 500.0).clamp(0.0, 1.0),
                      progressText: '$_points / 500 pts',
                      progressLabel: 'Status (${_points >= 500 ? "Ready" : "Locked"})',
                    ),
                    _buildPerkCard(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Municipal Citizen Certificate',
                      points: '1,000 pts',
                      subtitle: 'Official digital commendation from municipal administrative awareness board for public service.',
                      footerIcon: Icons.card_membership_outlined,
                      footerText: 'Official Recognition',
                      buttonLabel: _points >= 1000 ? 'Unlocked' : '${1000 - _points} pts needed',
                      isRedeemable: _points >= 1000,
                      progress: (_points / 1000.0).clamp(0.0, 1.0),
                      progressText: '$_points / 1,000 pts',
                      progressLabel: 'Status (${_points >= 1000 ? "Ready" : "Locked"})',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
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
            color: Colors.black.withValues(alpha: 0.02),
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
                  color: iconColor.withValues(alpha: 0.1),
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
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                        color: isClaimed ? const Color(0xFFDCFCE7) : AppTheme.accentBlue.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: isClaimed ? const Color(0xFF16A34A) : AppTheme.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
      width: 135,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: unlocked ? Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: unlocked ? AppTheme.primaryColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: unlocked ? AppTheme.primaryColor : Colors.grey, size: 22),
          ),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: unlocked ? AppTheme.textPrimary : Colors.grey)),
          const SizedBox(height: 4),
          Text(subtitle, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: unlocked ? AppTheme.textSecondary : Colors.grey, fontSize: 10)),
          const Spacer(),
          if (unlocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check, size: 10, color: Color(0xFF16A34A)),
                  SizedBox(width: 4),
                  Text('UNLOCKED', style: TextStyle(color: Color(0xFF16A34A), fontSize: 9, fontWeight: FontWeight.bold)),
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
            color: Colors.black.withValues(alpha: 0.02),
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
                  color: AppTheme.accentBlue.withValues(alpha: 0.3),
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
                Text(
                  progressText ?? '',
                  style: TextStyle(
                    color: isRedeemable ? const Color(0xFF16A34A) : Colors.orange[800],
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppTheme.backgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(isRedeemable ? const Color(0xFF16A34A) : AppTheme.primaryColor),
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
                  color: isRedeemable ? AppTheme.primaryColor : AppTheme.accentBlue.withValues(alpha: 0.5),
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
