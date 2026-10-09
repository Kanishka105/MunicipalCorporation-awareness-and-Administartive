class ActiveSubmissionStep {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;
  final String iconType; // check, dedup, dispatch, pending

  const ActiveSubmissionStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isCurrent,
    required this.iconType,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isCompleted': isCompleted,
    'isCurrent': isCurrent,
    'iconType': iconType,
  };

  factory ActiveSubmissionStep.fromJson(Map<String, dynamic> json) => ActiveSubmissionStep(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    isCompleted: json['isCompleted'] as bool? ?? false,
    isCurrent: json['isCurrent'] as bool? ?? false,
    iconType: json['iconType'] as String? ?? 'check',
  );
}

class ActiveSubmissionModel {
  final String id;
  final String ticketCode;
  final String title;
  final String location;
  final String timeAgo;
  final String status;
  final String statusColor;
  final List<ActiveSubmissionStep> steps;
  final String securityLockText;
  final String liveSlaUrl;

  const ActiveSubmissionModel({
    required this.id,
    required this.ticketCode,
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.status,
    required this.statusColor,
    required this.steps,
    required this.securityLockText,
    required this.liveSlaUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'ticketCode': ticketCode,
    'title': title,
    'location': location,
    'timeAgo': timeAgo,
    'status': status,
    'statusColor': statusColor,
    'steps': steps.map((e) => e.toJson()).toList(),
    'securityLockText': securityLockText,
    'liveSlaUrl': liveSlaUrl,
  };

  factory ActiveSubmissionModel.fromJson(Map<String, dynamic> json) => ActiveSubmissionModel(
    id: json['id'] as String,
    ticketCode: json['ticketCode'] as String,
    title: json['title'] as String,
    location: json['location'] as String,
    timeAgo: json['timeAgo'] as String,
    status: json['status'] as String,
    statusColor: json['statusColor'] as String,
    steps: (json['steps'] as List<dynamic>?)
            ?.map((e) => ActiveSubmissionStep.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    securityLockText: json['securityLockText'] as String,
    liveSlaUrl: json['liveSlaUrl'] as String,
  );
}

class HazardRadarModel {
  final String id;
  final String ticketCode;
  final String title;
  final String description;
  final String locationTag;
  final String nodeCode;
  final String aiTag;
  final String? badgeTag; // e.g., 'Urgent SLA' or 'Sanitation Unit #4'
  final bool isUrgent;
  final int backers;
  final String backerSubtext;
  final String slaTimeLeft;
  final String slaSubtext;
  final String imageUrl;
  final bool hasSupported;
  final DateTime createdAt;

  const HazardRadarModel({
    required this.id,
    required this.ticketCode,
    required this.title,
    required this.description,
    required this.locationTag,
    required this.nodeCode,
    required this.aiTag,
    this.badgeTag,
    this.isUrgent = false,
    required this.backers,
    required this.backerSubtext,
    required this.slaTimeLeft,
    required this.slaSubtext,
    required this.imageUrl,
    this.hasSupported = false,
    required this.createdAt,
  });

  HazardRadarModel copyWith({
    String? id,
    String? ticketCode,
    String? title,
    String? description,
    String? locationTag,
    String? nodeCode,
    String? aiTag,
    String? badgeTag,
    bool? isUrgent,
    int? backers,
    String? backerSubtext,
    String? slaTimeLeft,
    String? slaSubtext,
    String? imageUrl,
    bool? hasSupported,
    DateTime? createdAt,
  }) {
    return HazardRadarModel(
      id: id ?? this.id,
      ticketCode: ticketCode ?? this.ticketCode,
      title: title ?? this.title,
      description: description ?? this.description,
      locationTag: locationTag ?? this.locationTag,
      nodeCode: nodeCode ?? this.nodeCode,
      aiTag: aiTag ?? this.aiTag,
      badgeTag: badgeTag ?? this.badgeTag,
      isUrgent: isUrgent ?? this.isUrgent,
      backers: backers ?? this.backers,
      backerSubtext: backerSubtext ?? this.backerSubtext,
      slaTimeLeft: slaTimeLeft ?? this.slaTimeLeft,
      slaSubtext: slaSubtext ?? this.slaSubtext,
      imageUrl: imageUrl ?? this.imageUrl,
      hasSupported: hasSupported ?? this.hasSupported,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ticketCode': ticketCode,
    'title': title,
    'description': description,
    'locationTag': locationTag,
    'nodeCode': nodeCode,
    'aiTag': aiTag,
    'badgeTag': badgeTag,
    'isUrgent': isUrgent,
    'backers': backers,
    'backerSubtext': backerSubtext,
    'slaTimeLeft': slaTimeLeft,
    'slaSubtext': slaSubtext,
    'imageUrl': imageUrl,
    'hasSupported': hasSupported,
    'createdAt': createdAt.toIso8601String(),
  };

  factory HazardRadarModel.fromJson(Map<String, dynamic> json) => HazardRadarModel(
    id: json['id'] as String,
    ticketCode: json['ticketCode'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    locationTag: json['locationTag'] as String,
    nodeCode: json['nodeCode'] as String,
    aiTag: json['aiTag'] as String,
    badgeTag: json['badgeTag'] as String?,
    isUrgent: json['isUrgent'] as bool? ?? false,
    backers: json['backers'] as int? ?? 0,
    backerSubtext: json['backerSubtext'] as String? ?? '',
    slaTimeLeft: json['slaTimeLeft'] as String? ?? '',
    slaSubtext: json['slaSubtext'] as String? ?? '',
    imageUrl: json['imageUrl'] as String? ?? '',
    hasSupported: json['hasSupported'] as bool? ?? false,
    createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
  );
}
