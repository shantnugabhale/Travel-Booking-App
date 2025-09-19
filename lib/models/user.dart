class User {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String bio;
  final List<String> interests;
  final List<String> visitedDestinations;
  final List<String> savedItineraries;
  final DateTime createdAt;
  final DateTime lastLogin;
  final String travelStyle; // 'budget', 'luxury', 'adventure', 'cultural'
  final int totalTrips;
  final int totalReviews;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.interests,
    required this.visitedDestinations,
    required this.savedItineraries,
    required this.createdAt,
    required this.lastLogin,
    required this.travelStyle,
    required this.totalTrips,
    required this.totalReviews,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      interests: List<String>.from(json['interests'] ?? []),
      visitedDestinations: List<String>.from(json['visitedDestinations'] ?? []),
      savedItineraries: List<String>.from(json['savedItineraries'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLogin: DateTime.parse(json['lastLogin'] ?? DateTime.now().toIso8601String()),
      travelStyle: json['travelStyle'] ?? '',
      totalTrips: json['totalTrips'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'bio': bio,
      'interests': interests,
      'visitedDestinations': visitedDestinations,
      'savedItineraries': savedItineraries,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'travelStyle': travelStyle,
      'totalTrips': totalTrips,
      'totalReviews': totalReviews,
    };
  }
}
