enum UserRole {
  citizen,
  fieldOfficer,
  zonalSupervisor,
}

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String ward;
  final UserRole role;
  final int karmaPoints;
  final int streakDays;
  final String? unitId;
  final String? awsRegion;
  final double? gpsAccuracy;
  final int assignedTasks;
  final int clearedTasks;
  final int criticalTasks;
  final double rating;
  final String avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.ward,
    required this.role,
    this.karmaPoints = 340,
    this.streakDays = 7,
    this.unitId,
    this.awsRegion = 'ap-south-1',
    this.gpsAccuracy = 1.8,
    this.assignedTasks = 4,
    this.clearedTasks = 2,
    this.criticalTasks = 1,
    this.rating = 4.9,
    this.avatarUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? ward,
    UserRole? role,
    int? karmaPoints,
    int? streakDays,
    String? unitId,
    String? awsRegion,
    double? gpsAccuracy,
    int? assignedTasks,
    int? clearedTasks,
    int? criticalTasks,
    double? rating,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      ward: ward ?? this.ward,
      role: role ?? this.role,
      karmaPoints: karmaPoints ?? this.karmaPoints,
      streakDays: streakDays ?? this.streakDays,
      unitId: unitId ?? this.unitId,
      awsRegion: awsRegion ?? this.awsRegion,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      assignedTasks: assignedTasks ?? this.assignedTasks,
      clearedTasks: clearedTasks ?? this.clearedTasks,
      criticalTasks: criticalTasks ?? this.criticalTasks,
      rating: rating ?? this.rating,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'ward': ward,
      'role': role.name,
      'karmaPoints': karmaPoints,
      'streakDays': streakDays,
      'unitId': unitId,
      'awsRegion': awsRegion,
      'gpsAccuracy': gpsAccuracy,
      'assignedTasks': assignedTasks,
      'clearedTasks': clearedTasks,
      'criticalTasks': criticalTasks,
      'rating': rating,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      ward: json['ward'] as String? ?? 'DTU Ward 42',
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.citizen,
      ),
      karmaPoints: json['karmaPoints'] as int? ?? 340,
      streakDays: json['streakDays'] as int? ?? 7,
      unitId: json['unitId'] as String?,
      awsRegion: json['awsRegion'] as String? ?? 'ap-south-1',
      gpsAccuracy: (json['gpsAccuracy'] as num?)?.toDouble() ?? 1.8,
      assignedTasks: json['assignedTasks'] as int? ?? 4,
      clearedTasks: json['clearedTasks'] as int? ?? 2,
      criticalTasks: json['criticalTasks'] as int? ?? 1,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }
}
