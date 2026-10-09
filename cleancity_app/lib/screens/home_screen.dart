import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                              Text('Home', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle),
                              ),
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
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('EN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
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
              
              // Profile Section
              Row(
                children: [
                  Icon(Icons.verified_user_outlined, color: AppTheme.primaryGreen, size: 16),
                  const SizedBox(width: 4),
                  const Text('CIVIC CITIZEN PROFILE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Namaste, Priya ...', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                  // Language Toggle alternative view maybe
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textLight),
                  SizedBox(width: 4),
                  Text('Ward 142, Indiranagar, Bengaluru', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                ],
              ),
              const SizedBox(height: 20),

              // Report Card (Green Hero)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryGreen,
                      AppTheme.primaryGreen.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text('Smart Ward AI 2.0', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Report a Problem', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    const Text('समस्या दर्ज करें', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 12),
                    const Text('AI auto-detects waste category & ward in\nseconds', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/report');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Tap to Capture Grievance / फोटो खींचें', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Quick Categories / श्रेणियां', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('TAP TO REPORT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                ],
              ),
              const SizedBox(height: 12),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  _buildCategoryCard(Icons.delete_outline, 'Garbage Du...', 'कचरा ढेर', Colors.green[100]!, Colors.green[800]!),
                  _buildCategoryCard(Icons.restore_from_trash, 'Overflowing...', 'भरा हुआ कूड़ादान', Colors.blue[50]!, Colors.blue[800]!),
                  _buildCategoryCardWithTag(Icons.local_fire_department_outlined, 'Waste Burning', 'कचरा जलाना', Colors.orange[100]!, Colors.orange[800]!, 'Urgent', Colors.orange[800]!),
                  _buildCategoryCard(Icons.water_drop_outlined, 'Drain Blocked', 'नाली जाम', Colors.grey[200]!, Colors.grey[800]!),
                  _buildCategoryCard(Icons.construction, 'Construction', 'मलवे का ढेर', Colors.grey[200]!, Colors.grey[800]!),
                  _buildCategoryCardWithTag(Icons.warning_amber_rounded, 'Chemical', 'रासायनिक कचरा', Colors.red[700]!, Colors.white, 'High Risk', Colors.red[900]!, bg: Colors.red[100]),
                ],
              ),
              const SizedBox(height: 24),

              // Your Latest Report
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Your Latest Report / आपकी रिपोर्ट', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('View All (4)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                ],
              ),
              const SizedBox(height: 12),
              
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/grievance_detail'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                                image: const DecorationImage(
                                  // Placeholder image
                                  image: NetworkImage('https://images.unsplash.com/photo-1605281317010-fe5ffe798166?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryGreen.withOpacity(0.9),
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                  ),
                                  child: const Text('✓ 96% AI', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                                        child: const Text('#CC-84920', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
                                        child: const Text('Overflowing Bin', style: TextStyle(fontSize: 10, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textLight),
                                      SizedBox(width: 4),
                                      Expanded(child: Text('12th Main Road, Near Metro Pillar 84', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Icon(Icons.schedule, size: 14, color: AppTheme.warning),
                                      SizedBox(width: 4),
                                      Text('Resolving within ', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                                      Text('2h 45m', style: TextStyle(fontSize: 10, color: AppTheme.warning, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text('Assigned: BBMP Sanitation Squad 14', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Progress bar
                      Stack(
                        children: [
                          Container(height: 4, width: double.infinity, color: Colors.grey[200]),
                          Container(height: 4, width: MediaQuery.of(context).size.width * 0.6, color: AppTheme.primaryGreen),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Submitted 08:30 AM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            Text('SLA On-Track', style: TextStyle(fontSize: 10, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Impact Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.green[200], shape: BoxShape.circle),
                      child: const Icon(Icons.emoji_events, color: AppTheme.primaryGreen, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('SWACHH WARD IMPACT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppTheme.primaryGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                                child: const Text('Ward 142', style: TextStyle(fontSize: 8, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text('1,240 complaints resolved in your\nward this month!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text.rich(
                            TextSpan(
                              text: '98.4%',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen),
                              children: [
                                TextSpan(text: ' cleared within municipal SLA\ntimelines.', style: TextStyle(color: AppTheme.textLight, fontWeight: FontWeight.normal)),
                              ]
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Contact banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle),
                      child: Icon(Icons.support_agent, color: Colors.blue[400], size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ward Supervisor Contact', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('K. Suresh (East Zone Zone-Officer)', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50],
                        foregroundColor: Colors.blue[800],
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.call, size: 14),
                      label: const Text('Call Desk', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title, String subtitle, Color iconBg, Color iconColor, {Color? bg}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: bg != null ? Colors.white : AppTheme.textDark)),
                Text(subtitle, style: TextStyle(fontSize: 10, color: bg != null ? Colors.white70 : AppTheme.textLight)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryCardWithTag(IconData icon, String title, String subtitle, Color iconBg, Color iconColor, String tag, Color tagColor, {Color? bg}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: bg != null ? Colors.white : AppTheme.textDark)),
                Text(subtitle, style: TextStyle(fontSize: 10, color: bg != null ? Colors.white70 : AppTheme.textLight)),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(color: bg != null ? tagColor : tagColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(bg != null) const Icon(Icons.star, color: Colors.white, size: 8),
                      if(bg == null) Icon(Icons.warning, color: tagColor, size: 8),
                      const SizedBox(width: 2),
                      Text(tag, style: TextStyle(fontSize: 8, color: bg != null ? Colors.white : tagColor, fontWeight: FontWeight.bold)),
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
