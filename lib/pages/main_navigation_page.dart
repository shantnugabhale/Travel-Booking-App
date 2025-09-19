import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/pages/home_page.dart';
import 'package:travelapp/pages/itinerary_planner_page.dart';
import 'package:travelapp/pages/travel_tips_page.dart';
import 'package:travelapp/pages/community_placeholder_page.dart';
import 'package:travelapp/pages/review_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ItineraryPlannerPage(),
    const TravelTipsPage(),
    const CommunityPlaceholderPage(),
    const ReviewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.route),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.star),
            label: 'Reviews',
          ),
        ],
      ),
    );
  }
}
