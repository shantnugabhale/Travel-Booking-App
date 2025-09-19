class Review {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String destinationId;
  final String destinationName;
  final double rating;
  final String title;
  final String comment;
  final List<String> images;
  final DateTime createdAt;
  final List<String> helpfulVotes;
  final String tripType; // 'solo', 'couple', 'family', 'friends'
  final String visitDate;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.destinationId,
    required this.destinationName,
    required this.rating,
    required this.title,
    required this.comment,
    required this.images,
    required this.createdAt,
    required this.helpfulVotes,
    required this.tripType,
    required this.visitDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      destinationId: json['destinationId'] ?? '',
      destinationName: json['destinationName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      title: json['title'] ?? '',
      comment: json['comment'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      helpfulVotes: List<String>.from(json['helpfulVotes'] ?? []),
      tripType: json['tripType'] ?? '',
      visitDate: json['visitDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'destinationId': destinationId,
      'destinationName': destinationName,
      'rating': rating,
      'title': title,
      'comment': comment,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'helpfulVotes': helpfulVotes,
      'tripType': tripType,
      'visitDate': visitDate,
    };
  }
}
