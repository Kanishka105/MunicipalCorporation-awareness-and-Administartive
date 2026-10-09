class UrgentOfficerTaskModel {
  final String taskId;
  final String departmentTag;
  final String title;
  final String locationName;
  final String gpsCoordinates;
  final String distanceAway;
  final String aiRekognitionLabel;
  final String aiConfidence;
  final String reportedTime;
  final String citizenTicket;
  final String originalProofUrl;
  final Duration slaRemaining;
  final bool isResolved;

  const UrgentOfficerTaskModel({
    required this.taskId,
    required this.departmentTag,
    required this.title,
    required this.locationName,
    required this.gpsCoordinates,
    required this.distanceAway,
    required this.aiRekognitionLabel,
    required this.aiConfidence,
    required this.reportedTime,
    required this.citizenTicket,
    required this.originalProofUrl,
    required this.slaRemaining,
    this.isResolved = false,
  });

  UrgentOfficerTaskModel copyWith({
    String? taskId,
    String? departmentTag,
    String? title,
    String? locationName,
    String? gpsCoordinates,
    String? distanceAway,
    String? aiRekognitionLabel,
    String? aiConfidence,
    String? reportedTime,
    String? citizenTicket,
    String? originalProofUrl,
    Duration? slaRemaining,
    bool? isResolved,
  }) {
    return UrgentOfficerTaskModel(
      taskId: taskId ?? this.taskId,
      departmentTag: departmentTag ?? this.departmentTag,
      title: title ?? this.title,
      locationName: locationName ?? this.locationName,
      gpsCoordinates: gpsCoordinates ?? this.gpsCoordinates,
      distanceAway: distanceAway ?? this.distanceAway,
      aiRekognitionLabel: aiRekognitionLabel ?? this.aiRekognitionLabel,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      reportedTime: reportedTime ?? this.reportedTime,
      citizenTicket: citizenTicket ?? this.citizenTicket,
      originalProofUrl: originalProofUrl ?? this.originalProofUrl,
      slaRemaining: slaRemaining ?? this.slaRemaining,
      isResolved: isResolved ?? this.isResolved,
    );
  }

  Map<String, dynamic> toJson() => {
    'taskId': taskId,
    'departmentTag': departmentTag,
    'title': title,
    'locationName': locationName,
    'gpsCoordinates': gpsCoordinates,
    'distanceAway': distanceAway,
    'aiRekognitionLabel': aiRekognitionLabel,
    'aiConfidence': aiConfidence,
    'reportedTime': reportedTime,
    'citizenTicket': citizenTicket,
    'originalProofUrl': originalProofUrl,
    'slaRemainingSeconds': slaRemaining.inSeconds,
    'isResolved': isResolved,
  };

  factory UrgentOfficerTaskModel.fromJson(Map<String, dynamic> json) => UrgentOfficerTaskModel(
    taskId: json['taskId'] as String,
    departmentTag: json['departmentTag'] as String,
    title: json['title'] as String,
    locationName: json['locationName'] as String,
    gpsCoordinates: json['gpsCoordinates'] as String,
    distanceAway: json['distanceAway'] as String,
    aiRekognitionLabel: json['aiRekognitionLabel'] as String,
    aiConfidence: json['aiConfidence'] as String,
    reportedTime: json['reportedTime'] as String,
    citizenTicket: json['citizenTicket'] as String,
    originalProofUrl: json['originalProofUrl'] as String,
    slaRemaining: Duration(seconds: json['slaRemainingSeconds'] as int? ?? 1680),
    isResolved: json['isResolved'] as bool? ?? false,
  );
}

class CompletedTaskModel {
  final String taskId;
  final String aiDiffPercent;
  final String completionTime;
  final String title;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String citizenLabel;
  final String officerProofLabel;
  final double triageScore;
  final String supervisorStatus;

  const CompletedTaskModel({
    required this.taskId,
    required this.aiDiffPercent,
    required this.completionTime,
    required this.title,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.citizenLabel,
    required this.officerProofLabel,
    required this.triageScore,
    required this.supervisorStatus,
  });

  Map<String, dynamic> toJson() => {
    'taskId': taskId,
    'aiDiffPercent': aiDiffPercent,
    'completionTime': completionTime,
    'title': title,
    'beforeImageUrl': beforeImageUrl,
    'afterImageUrl': afterImageUrl,
    'citizenLabel': citizenLabel,
    'officerProofLabel': officerProofLabel,
    'triageScore': triageScore,
    'supervisorStatus': supervisorStatus,
  };

  factory CompletedTaskModel.fromJson(Map<String, dynamic> json) => CompletedTaskModel(
    taskId: json['taskId'] as String,
    aiDiffPercent: json['aiDiffPercent'] as String,
    completionTime: json['completionTime'] as String,
    title: json['title'] as String,
    beforeImageUrl: json['beforeImageUrl'] as String,
    afterImageUrl: json['afterImageUrl'] as String,
    citizenLabel: json['citizenLabel'] as String,
    officerProofLabel: json['officerProofLabel'] as String,
    triageScore: (json['triageScore'] as num?)?.toDouble() ?? 0.98,
    supervisorStatus: json['supervisorStatus'] as String,
  );
}
