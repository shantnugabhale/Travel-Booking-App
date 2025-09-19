import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/models/review.dart';
import 'package:travelapp/models/destination.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star',
  ];

  List<Review> _reviews = [];
  List<Destination> _destinations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Mock destinations
    _destinations = [
      Destination(
        id: '1',
        name: 'Tokyo, Japan',
        description: 'Experience the perfect blend of traditional culture and modern innovation.',
        imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
        country: 'Japan',
        city: 'Tokyo',
        budgetPerDay: 120.0,
        safetyRating: 9.5,
        activities: ['Temples', 'Shopping', 'Food Tours', 'Museums'],
        highlights: ['Sensoji Temple', 'Tokyo Skytree', 'Shibuya Crossing'],
        bestTimeToVisit: 'Spring (March-May)',
        currency: 'JPY',
        language: 'Japanese',
        averageRating: 4.8,
        reviewCount: 1250,
      ),
      Destination(
        id: '2',
        name: 'Santorini, Greece',
        description: 'Discover the iconic white-washed buildings and stunning sunsets.',
        imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=400',
        country: 'Greece',
        city: 'Santorini',
        budgetPerDay: 150.0,
        safetyRating: 8.8,
        activities: ['Beaches', 'Wine Tasting', 'Sunset Views', 'Archaeology'],
        highlights: ['Oia Village', 'Red Beach', 'Ancient Thera'],
        bestTimeToVisit: 'Summer (June-August)',
        currency: 'EUR',
        language: 'Greek',
        averageRating: 4.9,
        reviewCount: 980,
      ),
      Destination(
        id: '3',
        name: 'Reykjavik, Iceland',
        description: 'Explore the land of fire and ice with its dramatic landscapes.',
        imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400',
        country: 'Iceland',
        city: 'Reykjavik',
        budgetPerDay: 200.0,
        safetyRating: 9.2,
        activities: ['Northern Lights', 'Hot Springs', 'Glaciers', 'Whale Watching'],
        highlights: ['Blue Lagoon', 'Golden Circle', 'Hallgrímskirkja'],
        bestTimeToVisit: 'Summer (June-August)',
        currency: 'ISK',
        language: 'Icelandic',
        averageRating: 4.7,
        reviewCount: 750,
      ),
    ];

    // Mock reviews
    _reviews = [
      Review(
        id: '1',
        userId: 'user1',
        userName: 'Sarah Johnson',
        userAvatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
        destinationId: '1',
        destinationName: 'Tokyo, Japan',
        rating: 5.0,
        title: 'Absolutely Amazing Experience!',
        comment: 'Tokyo exceeded all my expectations! The city is incredibly safe, clean, and the people are so friendly. The food scene is out of this world - from street food to Michelin-starred restaurants. The public transportation is efficient and easy to navigate. I felt completely safe traveling solo as a woman. The temples and gardens provide peaceful escapes from the bustling city. Highly recommend visiting during cherry blossom season!',
        images: [
          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
          'https://images.unsplash.com/photo-1542640244-a10b6e5d1e2a?w=400',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        helpfulVotes: ['user2', 'user3', 'user4'],
        tripType: 'Solo',
        visitDate: 'March 2024',
      ),
      Review(
        id: '2',
        userId: 'user2',
        userName: 'Mike Chen',
        userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        destinationId: '2',
        destinationName: 'Santorini, Greece',
        rating: 4.5,
        title: 'Beautiful but Expensive',
        comment: 'Santorini is absolutely stunning - the sunsets are incredible and the white-washed buildings are picture-perfect. However, it\'s quite expensive, especially during peak season. The crowds can be overwhelming in Oia during sunset. I recommend staying in Fira or Imerovigli for better value. The wine tasting tours are fantastic and the local cuisine is delicious. Overall a great experience but budget accordingly.',
        images: [
          'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=400',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        helpfulVotes: ['user1', 'user5'],
        tripType: 'Couple',
        visitDate: 'August 2023',
      ),
      Review(
        id: '3',
        userId: 'user3',
        userName: 'Emma Wilson',
        userAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        destinationId: '3',
        destinationName: 'Reykjavik, Iceland',
        rating: 5.0,
        title: 'Magical Northern Lights Experience',
        comment: 'Iceland is like nowhere else on Earth! The landscapes are absolutely breathtaking - from glaciers to geysers to waterfalls. I was lucky enough to see the Northern Lights multiple times during my visit. The Blue Lagoon is a must-visit, though it\'s quite touristy. The Golden Circle tour covers all the major attractions. The food is surprisingly good, especially the seafood. It\'s expensive but worth every penny for the unique experiences.',
        images: [
          'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400',
          'https://images.unsplash.com/photo-1539650116574-75c0c6d73c6e?w=400',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        helpfulVotes: ['user1', 'user2', 'user4', 'user6'],
        tripType: 'Solo',
        visitDate: 'February 2024',
      ),
      Review(
        id: '4',
        userId: 'user4',
        userName: 'Alex Rodriguez',
        userAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        destinationId: '1',
        destinationName: 'Tokyo, Japan',
        rating: 4.0,
        title: 'Great City, Challenging Language Barrier',
        comment: 'Tokyo is an incredible city with so much to see and do. The technology, culture, and food are all amazing. However, the language barrier can be challenging - very few people speak English, so I recommend learning some basic Japanese phrases or using translation apps. The subway system is efficient but can be confusing at first. Overall, it\'s a fantastic destination for those willing to embrace the cultural differences.',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        helpfulVotes: ['user2'],
        tripType: 'Friends',
        visitDate: 'November 2023',
      ),
      Review(
        id: '5',
        userId: 'user5',
        userName: 'Lisa Park',
        userAvatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
        destinationId: '2',
        destinationName: 'Santorini, Greece',
        rating: 3.5,
        title: 'Overcrowded but Beautiful',
        comment: 'Santorini is undeniably beautiful, but the crowds can really take away from the experience. Oia during sunset is packed with tourists trying to get the perfect photo. The beaches are nice but not exceptional compared to other Greek islands. The accommodation is expensive for what you get. I\'d recommend visiting during shoulder season to avoid the crowds and get better prices.',
        images: [
          'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=400',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        helpfulVotes: [],
        tripType: 'Family',
        visitDate: 'July 2023',
      ),
      Review(
        id: '6',
        userId: 'user6',
        userName: 'David Kim',
        userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
        destinationId: '3',
        destinationName: 'Reykjavik, Iceland',
        rating: 4.5,
        title: 'Perfect for Adventure Seekers',
        comment: 'Iceland is perfect for those who love adventure and nature. The hiking opportunities are incredible, and the landscapes are constantly changing. The weather can be unpredictable, so pack layers and waterproof gear. The food scene in Reykjavik is surprisingly good with lots of international options. The cost of living is high, but the experiences are unique and memorable.',
        images: [
          'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        helpfulVotes: ['user1', 'user3'],
        tripType: 'Solo',
        visitDate: 'September 2023',
      ),
    ];
  }

  List<Review> get _filteredReviews {
    if (_selectedFilter == 'All') {
      return _reviews;
    }
    
    final starRating = int.parse(_selectedFilter.split(' ')[0]);
    return _reviews.where((review) => review.rating.floor() == starRating).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews & Ratings'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.plus),
            onPressed: _writeReview,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(),
          _buildStatsSection(),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection() {
    final totalReviews = _reviews.length;
    final averageRating = _reviews.isNotEmpty 
        ? _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length 
        : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Reviews',
              totalReviews.toString(),
              FontAwesomeIcons.comment,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Average Rating',
              averageRating.toStringAsFixed(1),
              FontAwesomeIcons.star,
              Colors.amber,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Destinations',
              _destinations.length.toString(),
              FontAwesomeIcons.mapPin,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          FaIcon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    final filteredReviews = _filteredReviews;
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredReviews.length,
        itemBuilder: (context, index) {
          final review = filteredReviews[index];
          return _buildReviewCard(review);
        },
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _showReviewDetail(review),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(review.userAvatar),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            review.visitDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        review.tripType,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      review.destinationName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return FaIcon(
                          FontAwesomeIcons.star,
                          size: 12,
                          color: index < review.rating.floor() ? Colors.amber : Colors.grey[300],
                        );
                      }),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  review.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  review.comment,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (review.images.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: review.images[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _helpfulVote(review),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 14,
                            color: review.helpfulVotes.isNotEmpty ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${review.helpfulVotes.length} helpful',
                            style: TextStyle(
                              fontSize: 12,
                              color: review.helpfulVotes.isNotEmpty ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _formatDate(review.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.share),
                      iconSize: 16,
                      onPressed: () => _shareReview(review),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
  }

  void _helpfulVote(Review review) {
    setState(() {
      if (review.helpfulVotes.contains('currentUser')) {
        review.helpfulVotes.remove('currentUser');
      } else {
        review.helpfulVotes.add('currentUser');
      }
    });
  }

  void _shareReview(Review review) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Review shared successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _writeReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Write a Review',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    border: OutlineInputBorder(),
                  ),
                  items: _destinations.map((destination) {
                    return DropdownMenuItem(
                      value: destination.id,
                      child: Text(destination.name),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Review Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Your Review',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Rating: '),
                    ...List.generate(5, (index) {
                      return IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        onPressed: () {},
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Review submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text('Submit Review'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewDetail(Review review) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: CachedNetworkImageProvider(review.userAvatar),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${review.visitDate} • ${review.tripType}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          review.destinationName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        review.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return FaIcon(
                            FontAwesomeIcons.star,
                            size: 16,
                            color: index < review.rating.floor() ? Colors.amber : Colors.grey[300],
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        review.rating.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    review.comment,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  if (review.images.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: review.images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: review.images[index],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _helpfulVote(review),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.thumbsUp,
                              size: 16,
                              color: review.helpfulVotes.isNotEmpty ? Colors.blue : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${review.helpfulVotes.length} helpful',
                              style: TextStyle(
                                fontSize: 14,
                                color: review.helpfulVotes.isNotEmpty ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () => _shareReview(review),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.share,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Share',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(review.createdAt),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
