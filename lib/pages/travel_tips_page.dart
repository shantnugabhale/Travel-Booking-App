import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/models/travel_tip.dart';

class TravelTipsPage extends StatefulWidget {
  const TravelTipsPage({super.key});

  @override
  State<TravelTipsPage> createState() => _TravelTipsPageState();
}

class _TravelTipsPageState extends State<TravelTipsPage> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Safety',
    'Budget',
    'Solo Travel',
    'Packing',
    'Transportation',
  ];

  List<TravelTip> _travelTips = [];

  @override
  void initState() {
    super.initState();
    _loadTravelTips();
  }

  void _loadTravelTips() {
    // Mock data - in real app, this would come from API
    _travelTips = [
      TravelTip(
        id: '1',
        title: 'Essential Safety Tips for Solo Travelers',
        content: 'Traveling solo can be incredibly rewarding, but safety should always be your top priority. Here are some essential safety tips:\n\n1. Always share your itinerary with someone you trust\n2. Keep copies of important documents\n3. Stay aware of your surroundings\n4. Trust your instincts\n5. Keep emergency contacts handy\n6. Use reputable accommodation\n7. Avoid walking alone at night in unfamiliar areas',
        category: 'Safety',
        imageUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800',
        author: 'Sarah Johnson',
        authorAvatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        tags: ['safety', 'solo travel', 'tips'],
        likes: 245,
        views: 1200,
        isFeatured: true,
      ),
      TravelTip(
        id: '2',
        title: 'Budget Travel Hacks: How to Travel More for Less',
        content: 'Traveling on a budget doesn\'t mean sacrificing experiences. Here are proven hacks to stretch your travel budget:\n\n1. Travel during off-peak seasons\n2. Use flight comparison websites\n3. Stay in hostels or Airbnb\n4. Cook your own meals sometimes\n5. Use public transportation\n6. Look for free walking tours\n7. Take advantage of student discounts\n8. Use travel credit cards for rewards',
        category: 'Budget',
        imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
        author: 'Mike Chen',
        authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        tags: ['budget', 'money', 'travel hacks'],
        likes: 189,
        views: 890,
        isFeatured: true,
      ),
      TravelTip(
        id: '3',
        title: 'The Ultimate Packing Guide for Any Trip',
        content: 'Packing efficiently is an art form. Here\'s how to pack like a pro:\n\n1. Make a packing list\n2. Roll your clothes instead of folding\n3. Use packing cubes\n4. Pack versatile clothing items\n5. Bring a universal adapter\n6. Pack a first aid kit\n7. Don\'t forget chargers and cables\n8. Leave room for souvenirs\n9. Use compression bags for bulky items\n10. Pack a small laundry bag',
        category: 'Packing',
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
        author: 'Emma Wilson',
        authorAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now().subtract(const Duration(days: 7)),
        tags: ['packing', 'organization', 'travel essentials'],
        likes: 156,
        views: 750,
        isFeatured: false,
      ),
      TravelTip(
        id: '4',
        title: 'Solo Travel Confidence: Overcoming Fear and Anxiety',
        content: 'Solo travel can be intimidating, but it\'s also incredibly empowering. Here\'s how to build confidence:\n\n1. Start with short trips close to home\n2. Join group activities and tours\n3. Stay in social accommodations\n4. Use apps to meet other travelers\n5. Learn basic phrases in the local language\n6. Have a backup plan for everything\n7. Celebrate small victories\n8. Remember that most people are friendly and helpful',
        category: 'Solo Travel',
        imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        author: 'Alex Rodriguez',
        authorAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
        tags: ['solo travel', 'confidence', 'mental health'],
        likes: 203,
        views: 1100,
        isFeatured: true,
      ),
      TravelTip(
        id: '5',
        title: 'Getting Around: Transportation Tips for Every Budget',
        content: 'Navigating transportation in a new place can be challenging. Here are tips for every budget:\n\n1. Research transportation options before you go\n2. Download local transportation apps\n3. Consider walking for short distances\n4. Use ride-sharing services wisely\n5. Learn about local taxi etiquette\n6. Consider renting a bike or scooter\n7. Use public transportation during off-peak hours\n8. Keep emergency transportation money separate',
        category: 'Transportation',
        imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800',
        author: 'Lisa Park',
        authorAvatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        updatedAt: DateTime.now().subtract(const Duration(days: 12)),
        tags: ['transportation', 'navigation', 'budget'],
        likes: 134,
        views: 650,
        isFeatured: false,
      ),
      TravelTip(
        id: '6',
        title: 'Digital Nomad Safety: Working Remotely While Traveling',
        content: 'Working while traveling requires extra safety considerations:\n\n1. Use VPN for secure internet connections\n2. Keep backup copies of important work files\n3. Have a reliable internet backup plan\n4. Secure your devices with strong passwords\n5. Be cautious with public WiFi\n6. Keep work and personal data separate\n7. Have a plan for power outages\n8. Consider travel insurance for digital nomads',
        category: 'Safety',
        imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800',
        author: 'David Kim',
        authorAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 15)),
        tags: ['digital nomad', 'work', 'cybersecurity'],
        likes: 98,
        views: 420,
        isFeatured: false,
      ),
    ];
  }

  List<TravelTip> get _filteredTips {
    if (_selectedCategory == 'All') {
      return _travelTips;
    }
    return _travelTips.where((tip) => tip.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Tips & Blog'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          _buildFeaturedTips(),
          _buildTipsList(),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
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

  Widget _buildFeaturedTips() {
    final featuredTips = _travelTips.where((tip) => tip.isFeatured).take(2).toList();
    
    if (featuredTips.isEmpty) return const SizedBox.shrink();
    
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featuredTips.length,
        itemBuilder: (context, index) {
          final tip = featuredTips[index];
          return _buildFeaturedTipCard(tip);
        },
      ),
    );
  }

  Widget _buildFeaturedTipCard(TravelTip tip) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => _showTipDetail(tip),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: tip.imageUrl,
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.heart,
                            size: 12,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tip.likes.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const FaIcon(
                            FontAwesomeIcons.eye,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tip.views.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
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

  Widget _buildTipsList() {
    final filteredTips = _filteredTips;
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredTips.length,
        itemBuilder: (context, index) {
          final tip = filteredTips[index];
          return _buildTipCard(tip);
        },
      ),
    );
  }

  Widget _buildTipCard(TravelTip tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _showTipDetail(tip),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: tip.imageUrl,
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
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(tip.category).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tip.category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(tip.category),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: CachedNetworkImageProvider(tip.authorAvatar),
                            onBackgroundImageError: (exception, stackTrace) {},
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tip.author,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.heart,
                            size: 12,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tip.likes.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const FaIcon(
                            FontAwesomeIcons.eye,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tip.views.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(tip.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Safety':
        return Colors.red;
      case 'Budget':
        return Colors.green;
      case 'Solo Travel':
        return Colors.purple;
      case 'Packing':
        return Colors.orange;
      case 'Transportation':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${(difference / 7).floor()} weeks ago';
    }
  }

  void _showTipDetail(TravelTip tip) {
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: tip.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(tip.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      tip.category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColor(tip.category),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tip.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: CachedNetworkImageProvider(tip.authorAvatar),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatDate(tip.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(tip.likes.toString()),
                          const SizedBox(width: 16),
                          const FaIcon(
                            FontAwesomeIcons.eye,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(tip.views.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    tip.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: tip.tags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
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
