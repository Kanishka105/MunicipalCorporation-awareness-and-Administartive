import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../theme.dart';
import 'login_screen.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final ApiService _apiService = ApiService();
  late Post _post;
  bool _isUpvoting = false;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  Future<void> _toggleUpvote() async {
    if (_isUpvoting) return;

    final token = await _apiService.getToken();
    if (token == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please sign in with Cognito to upvote posts'),
          action: SnackBarAction(
            label: 'Sign In',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ),
      );
      return;
    }

    setState(() => _isUpvoting = true);

    try {
      final res = await _apiService.upvotePost(_post.id);
      if (res != null && mounted) {
        setState(() {
          _post = _post.copyWith(
            upvotes: res['upvotes'] as int? ?? _post.upvotes,
            hasUpvoted: res['has_upvoted'] as bool? ?? !_post.hasUpvoted,
          );
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update upvote: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpvoting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _post),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.cloud_done, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            const Text('AWS S3 Civic Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(_post.authorAvatarUrl),
            radius: 14,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_post.authorAvatarUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _post.authorName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.accentBlue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _post.category.toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'S3 Archive Ref: ${_post.id.length > 12 ? _post.id.substring(0, 12) : _post.id}...',
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  _buildIconBtn(Icons.share_outlined),
                ],
              ),
            ),

            // Image
            Stack(
              children: [
                Image.network(
                  _post.imageUrl,
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    color: AppTheme.surfaceColor,
                    child: const Center(
                      child: Icon(Icons.broken_image_outlined, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: AppTheme.primaryColor),
                        const SizedBox(width: 6),
                        Text(_post.locationName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 6),
                        Text('GNSS Fix', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.cloud_upload_outlined, size: 14, color: Colors.white),
                        SizedBox(width: 6),
                        Text('Stored in AWS S3', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _post.description,
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // Upvote & Action Bar
                  Row(
                    children: [
                      InkWell(
                        onTap: _toggleUpvote,
                        borderRadius: BorderRadius.circular(24),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: _post.hasUpvoted ? AppTheme.primaryColor : AppTheme.accentBlue.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _post.hasUpvoted ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                color: _post.hasUpvoted ? Colors.white : AppTheme.primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _post.hasUpvoted ? 'Upvoted' : 'Upvote Issue',
                                style: TextStyle(
                                  color: _post.hasUpvoted ? Colors.white : AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _post.hasUpvoted ? Colors.white.withValues(alpha: 0.2) : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${_post.upvotes}',
                                  style: TextStyle(
                                    color: _post.hasUpvoted ? Colors.white : AppTheme.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_post.upvotes} Citizens Supported',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Map & Telemetry
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppTheme.accentBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.satellite_alt, color: AppTheme.primaryColor, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('AWS S3 Geotag Telemetry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(_post.locationName, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '${_post.latitude.toStringAsFixed(4)}°, ${_post.longitude.toStringAsFixed(4)}°',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.accentBlue.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: !kIsWeb
                                ? GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(_post.latitude, _post.longitude),
                                      zoom: 14,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId('postLocation'),
                                        position: LatLng(_post.latitude, _post.longitude),
                                      ),
                                    },
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                  )
                                : Container(
                                    color: const Color(0xFFF1F5F9),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.location_on, color: AppTheme.primaryColor, size: 36),
                                          const SizedBox(height: 6),
                                          Text(
                                            _post.locationName,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                          Text(
                                            'Lat: ${_post.latitude.toStringAsFixed(5)}, Long: ${_post.longitude.toStringAsFixed(5)}',
                                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _buildCoordCard('Latitude', '${_post.latitude.toStringAsFixed(5)}°')),
                            const SizedBox(width: 12),
                            Expanded(child: _buildCoordCard('Longitude', '${_post.longitude.toStringAsFixed(5)}°')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: AppTheme.textPrimary),
    );
  }

  Widget _buildCoordCard(String title, String val) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              Icon(Icons.gps_fixed, size: 12, color: AppTheme.textSecondary),
            ],
          ),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
