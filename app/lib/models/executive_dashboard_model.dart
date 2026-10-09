class LowConfidenceReviewItem {
  final String id;
  final String ticketCode;
  final String title;
  final String ward;
  final double aiConfidence;
  final String flagReason;
  final String detectedCategory;
  final String imageUrl;
  final String pHashScore;
  final String citizenMaskedPhone;
  final int severityScore;
  final bool isNearSensitiveZone;
  final String sensitiveZoneName;
  String status; // 'pending', 'approved', 'rejected'

  LowConfidenceReviewItem({
    required this.id,
    required this.ticketCode,
    required this.title,
    required this.ward,
    required this.aiConfidence,
    required this.flagReason,
    required this.detectedCategory,
    required this.imageUrl,
    required this.pHashScore,
    required this.citizenMaskedPhone,
    required this.severityScore,
    this.isNearSensitiveZone = false,
    this.sensitiveZoneName = '',
    this.status = 'pending',
  });
}

class ColdZoneInspectionItem {
  final String zoneId;
  final String name;
  final String ward;
  final String daysWithoutReport;
  final String riskFactor;
  final String suggestedAction;
  final String status;

  const ColdZoneInspectionItem({
    required this.zoneId,
    required this.name,
    required this.ward,
    required this.daysWithoutReport,
    required this.riskFactor,
    required this.suggestedAction,
    this.status = 'Inspection Recommended',
  });
}

class WardPerformanceComparison {
  final String wardName;
  final int openComplaints;
  final int slaMisses;
  final double clearanceRatePct;
  final double citizenTrustAvg;
  final int activeSquads;
  final String escalationLevel;

  const WardPerformanceComparison({
    required this.wardName,
    required this.openComplaints,
    required this.slaMisses,
    required this.clearanceRatePct,
    required this.citizenTrustAvg,
    required this.activeSquads,
    required this.escalationLevel,
  });
}
