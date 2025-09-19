import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travelapp/models/destination.dart';

class DestinationPage extends StatefulWidget {
  final String destinationId;

  const DestinationPage({super.key, required this.destinationId});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  Destination? _destination;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDestination();
  }

  void _loadDestination() {
    // Mock data - in real app, this would come from API
    final destinations = {
      '1': Destination(
        id: '1',
        name: 'Tokyo, Japan',
        description: 'Experience the perfect blend of traditional culture and modern innovation in Japan\'s bustling capital. Tokyo offers an incredible mix of ancient temples, cutting-edge technology, world-class cuisine, and vibrant neighborhoods that never sleep.',
        imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800',
        country: 'Japan',
        city: 'Tokyo',
        budgetPerDay: 120.0,
        safetyRating: 9.5,
        activities: ['Temples', 'Shopping', 'Food Tours', 'Museums', 'Gardens', 'Technology'],
        highlights: ['Sensoji Temple', 'Tokyo Skytree', 'Shibuya Crossing', 'Meiji Shrine', 'Tsukiji Market'],
        bestTimeToVisit: 'Spring (March-May)',
        currency: 'JPY',
        language: 'Japanese',
        averageRating: 4.8,
        reviewCount: 1250,
      ),
      '2': Destination(
        id: '2',
        name: 'Santorini, Greece',
        description: 'Discover the iconic white-washed buildings and stunning sunsets of this Greek island paradise. Santorini offers breathtaking views, crystal-clear waters, ancient history, and some of the most romantic sunsets in the world.',
        imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
        country: 'Greece',
        city: 'Santorini',
        budgetPerDay: 150.0,
        safetyRating: 8.8,
        activities: ['Beaches', 'Wine Tasting', 'Sunset Views', 'Archaeology', 'Volcano Tours'],
        highlights: ['Oia Village', 'Red Beach', 'Ancient Thera', 'Fira', 'Akrotiri'],
        bestTimeToVisit: 'Summer (June-August)',
        currency: 'EUR',
        language: 'Greek',
        averageRating: 4.9,
        reviewCount: 980,
      ),
      '3': Destination(
        id: '3',
        name: 'Reykjavik, Iceland',
        description: 'Explore the land of fire and ice with its dramatic landscapes and unique Nordic culture. Reykjavik serves as the perfect base for exploring Iceland\'s natural wonders including geysers, glaciers, and the Northern Lights.',
        imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=800',
        country: 'Iceland',
        city: 'Reykjavik',
        budgetPerDay: 200.0,
        safetyRating: 9.2,
        activities: ['Northern Lights', 'Hot Springs', 'Glaciers', 'Whale Watching', 'Geysers'],
        highlights: ['Blue Lagoon', 'Golden Circle', 'Hallgrímskirkja', 'Geysir', 'Gullfoss'],
        bestTimeToVisit: 'Summer (June-August)',
        currency: 'ISK',
        language: 'Icelandic',
        averageRating: 4.7,
        reviewCount: 750,
      ),
    };

    setState(() {
      _destination = destinations[widget.destinationId];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_destination == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Destination Not Found'),
        ),
        body: const Center(
          child: Text('Destination not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDestinationInfo(),
                _buildBudgetSection(),
                _buildSafetySection(),
                _buildActivitiesSection(),
                _buildHighlightsSection(),
                _buildReviewsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: _destination!.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.heart),
          onPressed: () {
            // Add to favorites
          },
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.share),
          onPressed: () {
            // Share destination
          },
        ),
      ],
    );
  }

  Widget _buildDestinationInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _destination!.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.locationDot,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                '${_destination!.city}, ${_destination!.country}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _destination!.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.star,
                size: 20,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              Text(
                _destination!.averageRating.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${_destination!.reviewCount} reviews)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.dollarSign,
                color: Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Budget Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Average daily budget: \$${_destination!.budgetPerDay.toInt()}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Currency: ${_destination!.currency}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.shield,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Safety Rating',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${_destination!.safetyRating}/10',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: _destination!.safetyRating / 10,
                  backgroundColor: Colors.green[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Activities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _destination!.activities.map((activity) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  activity,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Must-See Highlights',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._destination!.highlights.map((highlight) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.mapPin,
                    size: 16,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      highlight,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Reviews',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildReviewCard(
            'Sarah M.',
            'Amazing destination! The culture and food were incredible.',
            5.0,
            '2 days ago',
          ),
          _buildReviewCard(
            'John D.',
            'Great for solo travelers. Very safe and welcoming.',
            4.5,
            '1 week ago',
          ),
          _buildReviewCard(
            'Emma L.',
            'Beautiful place but quite expensive. Worth it though!',
            4.0,
            '2 weeks ago',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, String comment, double rating, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  name[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return FaIcon(
                    FontAwesomeIcons.star,
                    size: 12,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                context.go('/main/itinerary-planner');
              },
              icon: const FaIcon(FontAwesomeIcons.route),
              label: const Text('Plan Trip'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                context.go('/main/reviews');
              },
              icon: const FaIcon(FontAwesomeIcons.star),
              label: const Text('Write Review'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
