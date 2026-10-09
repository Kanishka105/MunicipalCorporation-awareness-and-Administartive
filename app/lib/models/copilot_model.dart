class StrategicVectorModel {
  final int number;
  final String title;
  final String description;

  const StrategicVectorModel({
    required this.number,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'number': number,
    'title': title,
    'description': description,
  };

  factory StrategicVectorModel.fromJson(Map<String, dynamic> json) => StrategicVectorModel(
    number: json['number'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

class HotspotLedgerItemModel {
  final String id;
  final String title;
  final String badgeText;
  final String locationSubtext;
  final String scheduleTitle;
  final String scheduleEta;
  final String telemetryText;
  final String actionButtonText;
  final bool isDispatched;

  const HotspotLedgerItemModel({
    required this.id,
    required this.title,
    required this.badgeText,
    required this.locationSubtext,
    required this.scheduleTitle,
    required this.scheduleEta,
    required this.telemetryText,
    required this.actionButtonText,
    this.isDispatched = false,
  });

  HotspotLedgerItemModel copyWith({
    String? id,
    String? title,
    String? badgeText,
    String? locationSubtext,
    String? scheduleTitle,
    String? scheduleEta,
    String? telemetryText,
    String? actionButtonText,
    bool? isDispatched,
  }) {
    return HotspotLedgerItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      badgeText: badgeText ?? this.badgeText,
      locationSubtext: locationSubtext ?? this.locationSubtext,
      scheduleTitle: scheduleTitle ?? this.scheduleTitle,
      scheduleEta: scheduleEta ?? this.scheduleEta,
      telemetryText: telemetryText ?? this.telemetryText,
      actionButtonText: actionButtonText ?? this.actionButtonText,
      isDispatched: isDispatched ?? this.isDispatched,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'badgeText': badgeText,
    'locationSubtext': locationSubtext,
    'scheduleTitle': scheduleTitle,
    'scheduleEta': scheduleEta,
    'telemetryText': telemetryText,
    'actionButtonText': actionButtonText,
    'isDispatched': isDispatched,
  };

  factory HotspotLedgerItemModel.fromJson(Map<String, dynamic> json) => HotspotLedgerItemModel(
    id: json['id'] as String,
    title: json['title'] as String,
    badgeText: json['badgeText'] as String,
    locationSubtext: json['locationSubtext'] as String,
    scheduleTitle: json['scheduleTitle'] as String,
    scheduleEta: json['scheduleEta'] as String,
    telemetryText: json['telemetryText'] as String,
    actionButtonText: json['actionButtonText'] as String,
    isDispatched: json['isDispatched'] as bool? ?? false,
  );
}

class CopilotChatMessage {
  final String id;
  final String sender; // 'user' or 'bedrock'
  final String text;
  final DateTime timestamp;
  final bool isGenerating;

  const CopilotChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.isGenerating = false,
  });
}
