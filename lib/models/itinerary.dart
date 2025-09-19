class Itinerary {
  final String id;
  final String userId;
  final String destinationId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final double budget;
  final List<String> interests;
  final List<DayPlan> dayPlans;
  final DateTime createdAt;
  final DateTime updatedAt;

  Itinerary({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.budget,
    required this.interests,
    required this.dayPlans,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      destinationId: json['destinationId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      numberOfDays: json['numberOfDays'] ?? 0,
      budget: (json['budget'] ?? 0).toDouble(),
      interests: List<String>.from(json['interests'] ?? []),
      dayPlans: (json['dayPlans'] as List<dynamic>?)
          ?.map((dayPlan) => DayPlan.fromJson(dayPlan))
          .toList() ?? [],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'destinationId': destinationId,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'numberOfDays': numberOfDays,
      'budget': budget,
      'interests': interests,
      'dayPlans': dayPlans.map((dayPlan) => dayPlan.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class DayPlan {
  final int dayNumber;
  final String title;
  final String description;
  final List<Activity> activities;
  final double estimatedCost;

  DayPlan({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.activities,
    required this.estimatedCost,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      dayNumber: json['dayNumber'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      activities: (json['activities'] as List<dynamic>?)
          ?.map((activity) => Activity.fromJson(activity))
          .toList() ?? [],
      estimatedCost: (json['estimatedCost'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'title': title,
      'description': description,
      'activities': activities.map((activity) => activity.toJson()).toList(),
      'estimatedCost': estimatedCost,
    };
  }
}

class Activity {
  final String id;
  final String name;
  final String description;
  final String type; // 'morning', 'afternoon', 'evening'
  final String location;
  final double cost;
  final int duration; // in hours
  final String imageUrl;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.location,
    required this.cost,
    required this.duration,
    required this.imageUrl,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      cost: (json['cost'] ?? 0).toDouble(),
      duration: json['duration'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'location': location,
      'cost': cost,
      'duration': duration,
      'imageUrl': imageUrl,
    };
  }
}
