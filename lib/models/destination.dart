class Destination {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String country;
  final String city;
  final double budgetPerDay;
  final double safetyRating;
  final List<String> activities;
  final List<String> highlights;
  final String bestTimeToVisit;
  final String currency;
  final String language;
  final double averageRating;
  final int reviewCount;

  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.country,
    required this.city,
    required this.budgetPerDay,
    required this.safetyRating,
    required this.activities,
    required this.highlights,
    required this.bestTimeToVisit,
    required this.currency,
    required this.language,
    required this.averageRating,
    required this.reviewCount,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      budgetPerDay: (json['budgetPerDay'] ?? 0).toDouble(),
      safetyRating: (json['safetyRating'] ?? 0).toDouble(),
      activities: List<String>.from(json['activities'] ?? []),
      highlights: List<String>.from(json['highlights'] ?? []),
      bestTimeToVisit: json['bestTimeToVisit'] ?? '',
      currency: json['currency'] ?? '',
      language: json['language'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'country': country,
      'city': city,
      'budgetPerDay': budgetPerDay,
      'safetyRating': safetyRating,
      'activities': activities,
      'highlights': highlights,
      'bestTimeToVisit': bestTimeToVisit,
      'currency': currency,
      'language': language,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
    };
  }
}
