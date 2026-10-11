import '../services/api_service.dart';

class Post {
  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String cameraInfo;
  final double latitude;
  final double longitude;
  final String elevation;
  final String locationName;
  final String imageUrl;
  final String title;
  final String description;
  final String category;
  final String citizenId;
  final int upvotes;
  final int comments;
  final bool hasUpvoted;
  final List<String> upvoters;

  Post({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.cameraInfo,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.locationName,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
    required this.citizenId,
    required this.upvotes,
    required this.comments,
    this.hasUpvoted = false,
    this.upvoters = const [],
  });

  Post copyWith({
    int? upvotes,
    bool? hasUpvoted,
    List<String>? upvoters,
  }) {
    return Post(
      id: id,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      timeAgo: timeAgo,
      cameraInfo: cameraInfo,
      latitude: latitude,
      longitude: longitude,
      elevation: elevation,
      locationName: locationName,
      imageUrl: imageUrl,
      title: title,
      description: description,
      category: category,
      citizenId: citizenId,
      upvotes: upvotes ?? this.upvotes,
      comments: comments,
      hasUpvoted: hasUpvoted ?? this.hasUpvoted,
      upvoters: upvoters ?? this.upvoters,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json, {String currentUserId = '', String currentMobile = ''}) {
    final gps = json['gps'] as Map<String, dynamic>? ?? {};
    final lat = (json['latitude'] ?? json['lat'] ?? gps['latitude'] as num?)?.toDouble() ?? 19.0760;
    final long = (json['longitude'] ?? json['long'] ?? gps['longitude'] as num?)?.toDouble() ?? 72.8777;

    final createdAt = json['created_at'] != null ? DateTime.tryParse(json['created_at']) ?? DateTime.now() : DateTime.now();
    final difference = DateTime.now().difference(createdAt);
    String timeAgoStr = 'Just now';
    if (difference.inDays > 0) {
      timeAgoStr = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      timeAgoStr = '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      timeAgoStr = '${difference.inMinutes}m ago';
    }

    String photoUrl = json['photo_url'] ?? '';
    if (photoUrl.startsWith('/api')) {
      photoUrl = '${ApiService.serverHost}$photoUrl';
    }

    final rawUpvoters = (json['upvoters'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    final upvotesCount = (json['upvotes'] as num?)?.toInt() ?? rawUpvoters.length;
    final userUpvoted = (currentUserId.isNotEmpty && rawUpvoters.contains(currentUserId)) ||
        (currentMobile.isNotEmpty && rawUpvoters.contains(currentMobile));
    final author = json['author_name'] ?? json['citizen_id'] ?? 'Citizen';

    final accuracy = json['gps_accuracy_m'] != null ? '±${json['gps_accuracy_m']}m' : 'GNSS Tagged';

    return Post(
      id: json['id'] ?? '',
      authorName: author,
      authorAvatarUrl: 'https://api.dicebear.com/7.x/bottts/png?seed=${author.hashCode}',
      timeAgo: timeAgoStr,
      cameraInfo: accuracy,
      latitude: lat,
      longitude: long,
      elevation: 'GNSS Lock',
      locationName: (json['category'] != null && json['category'].toString().isNotEmpty)
          ? '${json['category'].toString().toUpperCase()} SECTOR'
          : 'CIVIC ZONE',
      imageUrl: photoUrl.isNotEmpty ? photoUrl : 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=900',
      title: json['title'] ?? 'Community Civic Update',
      description: json['description'] ?? '',
      category: json['category'] ?? 'waste',
      citizenId: json['citizen_id'] ?? '',
      upvotes: upvotesCount,
      comments: 0,
      hasUpvoted: userUpvoted,
      upvoters: rawUpvoters,
    );
  }
}
