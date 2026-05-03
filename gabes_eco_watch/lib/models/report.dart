class Report {
  final String id;
  final String userId;
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final DateTime timestamp;
  final bool isAnonymous;

  Report({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.timestamp,
    required this.isAnonymous,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'category': category,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
      'isAnonymous': isAnonymous,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      userId: map['userId'],
      category: map['category'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      imageUrl: map['imageUrl'],
      timestamp: DateTime.parse(map['timestamp']),
      isAnonymous: map['isAnonymous'] ?? false,
    );
  }
}