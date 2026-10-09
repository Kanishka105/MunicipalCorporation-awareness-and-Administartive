import 'package:flutter/material.dart';
import '../theme.dart';

class FieldWorkerTasksScreen extends StatelessWidget {
  const FieldWorkerTasksScreen({Key? key}) : super(key: key);

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
            Icon(Icons.cleaning_services, color: AppTheme.primaryGreen, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Field Worker T...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('BBMP EAST ZONE • SQUAD\n#14', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                          SizedBox(height: 4),
                          Text('Field Worker Ta...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.greenAccent[100], borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: const [
                            Icon(Icons.circle, color: AppTheme.primaryGreen, size: 8),
                            SizedBox(width: 4),
                            Text('On Duty (08:00 - 16:00)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_outlined, size: 16, color: AppTheme.primaryGreen),
                          SizedBox(width: 8),
                          Text('Tuesday, 24 Oct • ', style: TextStyle(fontSize: 12)),
                          Text('8 Pending\nTasks', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                        child: const Text('Indiranagar\nEast', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
            
            // Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterPill('All (8)', true, null),
                  const SizedBox(width: 8),
                  _buildFilterPill('Due Soon', false, '3', badgeColor: Colors.orange[100], badgeTextColor: Colors.orange[900]),
                  const SizedBox(width: 8),
                  _buildFilterPill('Overdue', false, '1', badgeColor: Colors.red[100], badgeTextColor: Colors.red[900]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Urgent SLA Alert
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.red[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1 Urgent SLA Violation Imminent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red[900])),
                        Text('Hazmat ticket requires immediate containment protocol.', style: TextStyle(fontSize: 10, color: Colors.red[800])),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Task List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildTaskCard(
                    context,
                    tagText: '1h 15m remaining (CRITICAL)',
                    tagColor: Colors.red[700]!,
                    severity: 'CRITICAL / गंभीर',
                    severityBg: Colors.red[100]!,
                    severityTextCol: Colors.red[900]!,
                    icon: Icons.ac_unit, // Fallback for asterisk
                    iconColor: Colors.red,
                    title: 'Chemical Spill / Haz...',
                    id: '#HZ-108',
                    address: '8th Cross, 100ft Road, Near K...',
                    distance: '450 m away (6\nmins)',
                    status: 'Assigned',
                  ),
                  const SizedBox(height: 16),
                  _buildTaskCard(
                    context,
                    tagText: '2h 45m remaining',
                    tagColor: AppTheme.warning,
                    severity: 'HIGH / उच्च',
                    severityBg: Colors.orange[100]!,
                    severityTextCol: Colors.orange[900]!,
                    icon: Icons.delete_outline,
                    iconColor: AppTheme.warning,
                    title: 'Overflowing Bin',
                    id: '#SW-392',
                    address: '12th Main Road, Near Metro...',
                    distance: '1.2 km away',
                    status: 'Dispatch Ready',
                    onTap: () => Navigator.pushNamed(context, '/task_completion'), // Navigation linked to next screen
                  ),
                  const SizedBox(height: 16),
                  _buildTaskCard(
                    context,
                    tagText: '5h 20m remaining',
                    tagColor: Colors.green[300]!,
                    severity: 'MEDIUM',
                    severityBg: Colors.blue[100]!,
                    severityTextCol: Colors.blue[900]!,
                    icon: Icons.home_outlined,
                    iconColor: AppTheme.primaryGreen,
                    title: 'Drain Blocked',
                    id: '#DR-441',
                    address: '7th B Main, Indiranagar Club...',
                    distance: '2.1 km away',
                    status: 'Queued',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Shift Schedule Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.indigo[50], borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.restaurant, color: Colors.indigo[400], size: 16),
                          const SizedBox(width: 8),
                          const Text('Shift Schedule', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange[200], borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lunch at 13:00', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('3 tasks due before lunch break. Keep dispatch updated on mobile radio.', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Squad Helpline', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[100],
                          foregroundColor: Colors.red[900],
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.call, size: 14),
                        label: const Text('Call 1913 (Urgent Dispatch)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
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

  Widget _buildFilterPill(String text, bool isActive, String? badge, {Color? badgeColor, Color? badgeTextColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryGreen : Colors.white,
        border: Border.all(color: isActive ? AppTheme.primaryGreen : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isActive ? Colors.white : AppTheme.textDark)),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(10)),
              child: Text(badge, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeTextColor)),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, {
    required String tagText,
    required Color tagColor,
    required String severity,
    required Color severityBg,
    required Color severityTextCol,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String id,
    required String address,
    required String distance,
    required String status,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          // Card Header with Timer
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(tagText, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: severityBg, borderRadius: BorderRadius.circular(12)),
                  child: Text(severity, style: TextStyle(color: severityTextCol, fontSize: 8, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          
          // Card Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1605281317010-fe5ffe798166?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      color: Colors.black54,
                      child: Text(id, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                          Icon(icon, color: iconColor, size: 16),
                          const SizedBox(width: 4),
                          Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(address, style: const TextStyle(fontSize: 12, color: AppTheme.textLight)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.near_me_outlined, size: 12, color: AppTheme.primaryGreen),
                              const SizedBox(width: 4),
                              Text(distance, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.circle, size: 8, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(status, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onTap ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.play_circle_outline, size: 16),
                    label: const Text('Start Task / कार्य शुरू करें', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.indigo[50], borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.directions, color: Colors.indigo[800]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
