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
    return Post(
      id: json['id'] ?? '',
      authorName: json['authorName'] ?? 'Unknown User',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      timeAgo: json['timeAgo'] ?? 'Just now',
      cameraInfo: json['cameraInfo'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      elevation: json['elevation'] ?? '0m',
      locationName: json['locationName'] ?? 'Unknown Location',
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      upvotes: json['upvotes'] ?? 0,
      comments: json['comments'] ?? 0,
    );
  }
}
