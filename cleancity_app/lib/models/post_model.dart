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
  final int upvotes;
  final int comments;

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
    required this.upvotes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Map backend ReportOut to Flutter Post model
    final gps = json['gps'] ?? {'latitude': 0.0, 'longitude': 0.0};
    final createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now();
    final difference = DateTime.now().difference(createdAt);
    String timeAgoStr = '${difference.inHours} hours ago';
    if (difference.inHours == 0) {
      timeAgoStr = '${difference.inMinutes} mins ago';
    } else if (difference.inDays > 0) {
      timeAgoStr = '${difference.inDays} days ago';
    }
    
    // Construct absolute URL for photo if it's a relative path
    String photoUrl = json['photo_url'] ?? '';
    if (photoUrl.startsWith('/api')) {
      photoUrl = 'http://10.0.2.2:5000' + photoUrl;
    }

    return Post(
      id: json['id'] ?? '',
      authorName: json['citizen_id'] ?? 'Unknown Citizen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/lego/1.jpg', // Placeholder
      timeAgo: timeAgoStr,
      cameraInfo: 'SmartPhone',
      latitude: (gps['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (gps['longitude'] as num?)?.toDouble() ?? 0.0,
      elevation: '0m', // Default if backend doesn't provide
      locationName: json['category'] ?? 'General',
      imageUrl: photoUrl.isNotEmpty ? photoUrl : 'https://via.placeholder.com/400x300.png?text=No+Image',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      upvotes: 0,
      comments: 0,
    );
  }
}
