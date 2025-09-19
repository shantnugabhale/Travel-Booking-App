import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelapp/pages/home_page.dart';
import 'package:travelapp/pages/destination_page.dart';
import 'package:travelapp/pages/itinerary_planner_page.dart';
import 'package:travelapp/pages/travel_tips_page.dart';
import 'package:travelapp/pages/community_placeholder_page.dart';
import 'package:travelapp/pages/review_page.dart';
import 'package:travelapp/pages/about_contact_page.dart';
import 'package:travelapp/pages/user_profile_page.dart';
import 'package:travelapp/auth/login_page.dart';
import 'package:travelapp/auth/forgot_password_page.dart';
import 'package:travelapp/pages/main_navigation_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainNavigationPage(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'destination/:id',
            builder: (context, state) {
              final destinationId = state.pathParameters['id']!;
              return DestinationPage(destinationId: destinationId);
            },
          ),
          GoRoute(
            path: 'itinerary-planner',
            builder: (context, state) => const ItineraryPlannerPage(),
          ),
          GoRoute(
            path: 'travel-tips',
            builder: (context, state) => const TravelTipsPage(),
          ),
          GoRoute(
            path: 'community',
            builder: (context, state) => const CommunityPlaceholderPage(),
          ),
          GoRoute(
            path: 'reviews',
            builder: (context, state) => const ReviewPage(),
          ),
          GoRoute(
            path: 'about-contact',
            builder: (context, state) => const AboutContactPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const UserProfilePage(),
          ),
        ],
      ),
    ],
  );
}
