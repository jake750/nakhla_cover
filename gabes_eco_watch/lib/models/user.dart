class UserProfile {
  final String uid;
  final String? email;
  final String? displayName;
  final int impactPoints;
  final List<String> reports;

  UserProfile({
    required this.uid,
    this.email,
    this.displayName,
    this.impactPoints = 0,
    this.reports = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'impactPoints': impactPoints,
      'reports': reports,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      impactPoints: map['impactPoints'] ?? 0,
      reports: List<String>.from(map['reports'] ?? []),
    );
  }
}