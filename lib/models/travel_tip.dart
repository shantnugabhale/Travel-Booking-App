class TravelTip {
  final String id;
  final String title;
  final String content;
  final String category; // 'safety', 'budget', 'solo_travel', 'packing', 'transportation'
  final String imageUrl;
  final String author;
  final String authorAvatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final int likes;
  final int views;
  final bool isFeatured;

  TravelTip({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.imageUrl,
    required this.author,
    required this.authorAvatar,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.likes,
    required this.views,
    required this.isFeatured,
  });

  factory TravelTip.fromJson(Map<String, dynamic> json) {
    return TravelTip(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      author: json['author'] ?? '',
      authorAvatar: json['authorAvatar'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      tags: List<String>.from(json['tags'] ?? []),
      likes: json['likes'] ?? 0,
      views: json['views'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'imageUrl': imageUrl,
      'author': author,
      'authorAvatar': authorAvatar,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'likes': likes,
      'views': views,
      'isFeatured': isFeatured,
    };
  }
}
