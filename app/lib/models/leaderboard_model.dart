class CitizenLeaderboardEntry {
  final int rank;
  final String name;
  final String ward;
  final int karmaPoints;
  final int verifiedReports;
  final double trustScore;
  final String badge;
  final String avatarUrl;

  const CitizenLeaderboardEntry({
    required this.rank,
    required this.name,
    required this.ward,
    required this.karmaPoints,
    required this.verifiedReports,
    required this.trustScore,
    required this.badge,
    required this.avatarUrl,
  });
}

class CitizenFixSuggestion {
  final String id;
  final String ticketCode;
  final String citizenName;
  final String suggestionText;
  final int upvotes;
  final DateTime createdAt;
  final bool hasUpvoted;

  const CitizenFixSuggestion({
    required this.id,
    required this.ticketCode,
    required this.citizenName,
    required this.suggestionText,
    required this.upvotes,
    required this.createdAt,
    this.hasUpvoted = false,
  });

  CitizenFixSuggestion copyWith({
    String? id,
    String? ticketCode,
    String? citizenName,
    String? suggestionText,
    int? upvotes,
    DateTime? createdAt,
    bool? hasUpvoted,
  }) {
    return CitizenFixSuggestion(
      id: id ?? this.id,
      ticketCode: ticketCode ?? this.ticketCode,
      citizenName: citizenName ?? this.citizenName,
      suggestionText: suggestionText ?? this.suggestionText,
      upvotes: upvotes ?? this.upvotes,
      createdAt: createdAt ?? this.createdAt,
      hasUpvoted: hasUpvoted ?? this.hasUpvoted,
    );
  }
}
