import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../theme.dart';
import '../screens/post_detail_screen.dart';
import '../screens/login_screen.dart';
import '../services/api_service.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback? onPostUpdated;

  const PostCard({super.key, required this.post, this.onPostUpdated});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _upvotes;
  late bool _hasUpvoted;
  bool _isUpvoting = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _upvotes = widget.post.upvotes;
    _hasUpvoted = widget.post.hasUpvoted;
  }

  @override
  void didUpdateWidget(covariant PostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.id != widget.post.id || oldWidget.post.upvotes != widget.post.upvotes || oldWidget.post.hasUpvoted != widget.post.hasUpvoted) {
      _upvotes = widget.post.upvotes;
      _hasUpvoted = widget.post.hasUpvoted;
    }
  }

  Future<void> _handleUpvote() async {
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

    setState(() {
      _isUpvoting = true;
      if (_hasUpvoted) {
        _hasUpvoted = false;
        _upvotes = (_upvotes > 0) ? _upvotes - 1 : 0;
      } else {
        _hasUpvoted = true;
        _upvotes += 1;
      }
    });

    final res = await _apiService.upvotePost(widget.post.id);
    if (!mounted) return;

    setState(() {
      _isUpvoting = false;
      if (res != null) {
        _upvotes = res['upvotes'] ?? _upvotes;
        _hasUpvoted = res['has_upvoted'] ?? _hasUpvoted;
      }
    });

    widget.onPostUpdated?.call();
  }

  @override
  Widget build(BuildContext context) {
    final latDir = widget.post.latitude >= 0 ? 'N' : 'S';
    final lonDir = widget.post.longitude >= 0 ? 'E' : 'W';
    final latStr = '${widget.post.latitude.abs().toStringAsFixed(4)}° $latDir';
    final lonStr = '${widget.post.longitude.abs().toStringAsFixed(4)}° $lonDir';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PostDetailScreen(post: widget.post)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor,
                    radius: 18,
                    child: Text(
                      widget.post.authorName.isNotEmpty ? widget.post.authorName[0].toUpperCase() : 'C',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.post.authorName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, color: AppTheme.primaryColor, size: 14),
                          ],
                        ),
                        Text(
                          '${widget.post.timeAgo} • ${widget.post.cameraInfo}',
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.post.category.toUpperCase(),
                      style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.post.imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.broken_image, color: Colors.grey, size: 48),
                          SizedBox(height: 8),
                          Text('Evidence Snapshot in S3', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          '$latStr, $lonStr',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.cloud_done, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'S3 Synced',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
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
                    widget.post.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (widget.post.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      widget.post.description,
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.4),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Upvote Button
                      GestureDetector(
                        onTap: _handleUpvote,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _hasUpvoted ? AppTheme.primaryColor : AppTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _hasUpvoted ? AppTheme.primaryColor : Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 16,
                                color: _hasUpvoted ? Colors.white : AppTheme.textPrimary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$_upvotes Upvotes',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _hasUpvoted ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.share_outlined, size: 16, color: AppTheme.textPrimary),
                            const SizedBox(width: 6),
                            Text('Share', style: TextStyle(fontSize: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
