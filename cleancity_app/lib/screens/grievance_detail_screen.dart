import 'package:flutter/material.dart';
import '../theme.dart';

class GrievanceDetailScreen extends StatelessWidget {
  const GrievanceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.receipt_long, color: AppTheme.primaryGreen, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Grievance Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    const Text('Ward Active', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                  ],
                )
              ],
            )
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: AppTheme.primaryGreen, borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text('EN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
          ),
          const SizedBox(width: 4),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text('हि', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12))),
          ),
          const SizedBox(width: 12),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
            child: Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 20),
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle),
            child: const Icon(Icons.person_outline, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Breadcrumbs / ID
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text('#CC-84920', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                      Text(' • Ward 142 • Indiranagar', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                        child: const Icon(Icons.share_outlined, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                        child: const Icon(Icons.notifications_none_outlined, size: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Image Area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1605281317010-fe5ffe798166?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Top labels
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.warning, borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: const [
                            Icon(Icons.warning, color: Colors.white, size: 12),
                            SizedBox(width: 4),
                            Text('High Severity / उच्च प्राथमिकता', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                        child: const Text('12th Main Road', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // AI Annotations (Mocked visually)
                    Center(
                      child: Container(
                        width: 280,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent.withOpacity(0.5), width: 1),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                color: Colors.orangeAccent.withOpacity(0.8),
                                child: const Text('BBMP-AI: Spill Box #01', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                color: Colors.white.withOpacity(0.8),
                                child: const Text('94.2%', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                color: Colors.orangeAccent.withOpacity(0.8),
                                child: const Text('1.8m² Footprint', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Bottom AI Analysis tags
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildTag(Icons.delete_outline, 'Overflow 94%', Colors.blue[50]!, Colors.blue[800]!),
                              const SizedBox(width: 4),
                              _buildTag(Icons.category, 'Mixed Plastic 88%', Colors.orange[50]!, Colors.orange[800]!),
                            ],
                          ),
                          const SizedBox(height: 4),
                          _buildTag(Icons.warning_amber, 'Pedestrian Hazard', Colors.red[50]!, Colors.red[800]!),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            
            // Tab Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        border: Border.all(color: AppTheme.primaryGreen),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt_outlined, size: 14, color: AppTheme.primaryGreen),
                          SizedBox(width: 4),
                          Text('Initial Report', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.blue[100]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.compare, size: 14, color: Colors.blue[800]),
                          const SizedBox(width: 4),
                          Text('Current State', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SLA Countdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.timer_outlined, size: 16, color: AppTheme.textDark),
                          SizedBox(width: 4),
                          Text('Municipal SLA Countdown', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(12)),
                        child: const Text('ON-TRACK', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('2h 45m remaining', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(height: 6, width: double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3))),
                      Container(height: 6, width: MediaQuery.of(context).size.width * 0.68, decoration: BoxDecoration(color: AppTheme.primaryGreen, borderRadius: BorderRadius.circular(3))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Target Window: 6 Hours', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('68% Elapsed', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(color: AppTheme.primaryGreen, shape: BoxShape.circle),
                          child: const Center(child: Text('MR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Officer M. Raghavan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('BBMP Sanitation Squad #14', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey[200]!), shape: BoxShape.circle),
                          child: const Icon(Icons.call_outlined, color: AppTheme.primaryGreen, size: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Audit Trail
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Grievance Audit Trail', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Updated 4m ago', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTimelineItem(Icons.check, 'Reported', 'दर्ज किया गया • Oct 24', 'Submitted via CleanCity Citizen Portal with GPS geotag lock.', '08:30 AM', true),
                  _buildTimelineItem(Icons.smart_toy_outlined, 'AI Verified', 'एआई द्वारा सत्यापित • Oct 24', null, '08:32 AM', true, tags: ['94% Confidence', 'Auto-Categorized']),
                  _buildTimelineItem(Icons.assignment_ind_outlined, 'Assigned', 'अधिकारी नियुक्त • Oct 24', 'Squad 14 auto-routed under East Zone Solid Waste Directive.', '09:15 AM', true),
                  _buildTimelineItem(Icons.hourglass_bottom, 'In Progress', 'सफाई जारी है • Transit Phase', 'Compactor Truck KA-04-G-8821 in transit to location point.', 'Active', true, isCurrent: true),
                  _buildTimelineItem(Icons.check_circle_outline, 'Resolved & Cleaned', 'सफलतापूर्वक निस्तारित', 'Pending physical post-cleanup evidence and QA geotag.', 'Pending', false),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Incident Coordinates
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 16, color: AppTheme.primaryGreen),
                            SizedBox(width: 4),
                            Text('Incident Coordinates', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('12.9784° N, 77.6408° E', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=12.9784,77.6408&zoom=14&size=400x120&sensor=false'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: const [
                                Icon(Icons.navigation_outlined, size: 14, color: AppTheme.primaryGreen),
                                SizedBox(width: 4),
                                Text('Corner of 12th Main & 4th Cross Road', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Neighbors Verified
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.green[100], shape: BoxShape.circle),
                    child: const Icon(Icons.thumb_up_alt_outlined, color: AppTheme.primaryGreen, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('42 Neighbors Verified', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text('Upvoted in Ward 142 grievance feed', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: const [
                        Icon(Icons.add, size: 14, color: AppTheme.primaryGreen),
                        SizedBox(width: 4),
                        Text('Confirm', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(0, 48),
                      ),
                      icon: const Icon(Icons.chat_outlined, size: 18),
                      label: const Text('Add a Suggestion / टिप्पणी जोड़ें', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red[800],
                        minimumSize: const Size(0, 48),
                      ),
                      icon: const Icon(Icons.headset_mic_outlined, size: 18),
                      label: const Text('Call 1913', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(IconData icon, String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: bg.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textCol, size: 10),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: textCol, fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(IconData icon, String title, String subtitle, String? description, String time, bool isCompleted, {bool isCurrent = false, List<String>? tags}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isCurrent ? AppTheme.warning : (isCompleted ? Colors.green[100] : Colors.white),
                shape: BoxShape.circle,
                border: Border.all(color: isCompleted ? (isCurrent ? AppTheme.warning : Colors.green[200]!) : Colors.grey[300]!),
              ),
              child: Icon(
                icon,
                size: 16,
                color: isCurrent ? Colors.white : (isCompleted ? AppTheme.primaryGreen : Colors.grey[400]),
              ),
            ),
            if (title != 'Resolved & Cleaned')
              Container(width: 2, height: description != null ? 50 : 30, color: isCompleted ? AppTheme.primaryGreen : Colors.grey[200]),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isCompleted ? AppTheme.textDark : Colors.grey[500])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: isCurrent ? BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(4)) : null,
                    child: Text(time, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCurrent ? AppTheme.warning : (isCompleted ? AppTheme.textDark : Colors.grey[400]))),
                  ),
                ],
              ),
              Text(subtitle, style: TextStyle(fontSize: 10, color: isCompleted ? AppTheme.textLight : Colors.grey[400])),
              if (tags != null) ...[
                const SizedBox(height: 6),
                Row(
                  children: tags.map((t) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                    child: Text(t, style: TextStyle(fontSize: 8, color: Colors.blue[800], fontWeight: FontWeight.bold)),
                  )).toList(),
                )
              ],
              if (description != null) ...[
                const SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 12, color: isCompleted ? AppTheme.textDark : Colors.grey[400])),
              ],
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }
}
