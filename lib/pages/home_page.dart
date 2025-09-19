import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travelapp/models/destination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Destination> _featuredDestinations = [];
  List<Destination> _popularDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  void _loadDestinations() {
    // Mock data - in real app, this would come from API
    _featuredDestinations = [
      Destination(
        id: '1',
        name: 'Tokyo, Japan',
        description: 'Experience the perfect blend of traditional culture and modern innovation in Japan\'s bustling capital.',
        imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800',
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
        description: 'Discover the iconic white-washed buildings and stunning sunsets of this Greek island paradise.',
        imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
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
        description: 'Explore the land of fire and ice with its dramatic landscapes and unique Nordic culture.',
        imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=800',
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

    _popularDestinations = [
      Destination(
        id: '4',
        name: 'Bali, Indonesia',
        description: 'Tropical paradise with beautiful beaches, ancient temples, and vibrant culture.',
        imageUrl: 'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=800',
        country: 'Indonesia',
        city: 'Bali',
        budgetPerDay: 80.0,
        safetyRating: 8.5,
        activities: ['Beaches', 'Temples', 'Rice Terraces', 'Diving'],
        highlights: ['Ubud', 'Tanah Lot', 'Tegallalang Rice Terraces'],
        bestTimeToVisit: 'Dry Season (April-October)',
        currency: 'IDR',
        language: 'Indonesian',
        averageRating: 4.6,
        reviewCount: 2100,
      ),
      Destination(
        id: '5',
        name: 'Paris, France',
        description: 'The City of Light offers world-class art, cuisine, and iconic landmarks.',
        imageUrl: 'https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=800',
        country: 'France',
        city: 'Paris',
        budgetPerDay: 180.0,
        safetyRating: 8.0,
        activities: ['Museums', 'Shopping', 'Food Tours', 'Architecture'],
        highlights: ['Eiffel Tower', 'Louvre', 'Notre-Dame'],
        bestTimeToVisit: 'Spring (April-June)',
        currency: 'EUR',
        language: 'French',
        averageRating: 4.5,
        reviewCount: 3200,
      ),
      Destination(
        id: '6',
        name: 'New York, USA',
        description: 'The city that never sleeps offers endless entertainment and cultural experiences.',
        imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800',
        country: 'USA',
        city: 'New York',
        budgetPerDay: 250.0,
        safetyRating: 7.5,
        activities: ['Broadway', 'Museums', 'Shopping', 'Food'],
        highlights: ['Times Square', 'Central Park', 'Statue of Liberty'],
        bestTimeToVisit: 'Fall (September-November)',
        currency: 'USD',
        language: 'English',
        averageRating: 4.4,
        reviewCount: 2800,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Travel Explorer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.user),
            onPressed: () {
              context.go('/main/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            _buildSearchSection(),
            _buildFeaturedDestinations(),
            _buildPopularDestinations(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover your next adventure',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where do you want to go?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Container(
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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search destinations...',
                prefixIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                // Handle search
                _performSearch(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDestinations() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Destinations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredDestinations.length,
              itemBuilder: (context, index) {
                final destination = _featuredDestinations[index];
                return _buildDestinationCard(destination, isFeatured: true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDestinations() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Destinations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularDestinations.length,
              itemBuilder: (context, index) {
                final destination = _popularDestinations[index];
                return _buildDestinationCard(destination, isFeatured: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(Destination destination, {required bool isFeatured}) {
    return Container(
      width: isFeatured ? 280 : 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            context.go('/main/destination/${destination.id}');
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: destination.imageUrl,
                    width: double.infinity,
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
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        destination.country,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.star,
                            size: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination.averageRating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${destination.budgetPerDay.toInt()}/day',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Plan Trip',
                  FontAwesomeIcons.route,
                  Colors.blue,
                  () => context.go('/main/itinerary-planner'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Travel Tips',
                  FontAwesomeIcons.lightbulb,
                  Colors.orange,
                  () => context.go('/main/travel-tips'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Community',
                  FontAwesomeIcons.users,
                  Colors.green,
                  () => context.go('/main/community'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Reviews',
                  FontAwesomeIcons.star,
                  Colors.purple,
                  () => context.go('/main/reviews'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FaIcon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSearch(String query) {
    // Handle search functionality
    print('Searching for: $query');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}