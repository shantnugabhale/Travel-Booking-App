import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/models/destination.dart';
import 'package:travelapp/models/itinerary.dart';
import 'package:travelapp/models/review.dart';
import 'package:travelapp/models/travel_tip.dart';
import 'package:travelapp/models/community_post.dart';
import 'package:travelapp/models/user.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic methods for storing and retrieving data
  static Future<void> _setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? _getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<void> _setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  static List<String>? _getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  static Future<void> _setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int? _getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<void> _setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? _getBool(String key) {
    return _prefs?.getBool(key);
  }

  // User preferences
  static Future<void> saveUserPreferences({
    String? theme,
    String? language,
    bool? notifications,
    String? currency,
  }) async {
    if (theme != null) await _setString('user_theme', theme);
    if (language != null) await _setString('user_language', language);
    if (notifications != null) await _setBool('user_notifications', notifications);
    if (currency != null) await _setString('user_currency', currency);
  }

  static Map<String, dynamic> getUserPreferences() {
    return {
      'theme': _getString('user_theme') ?? 'light',
      'language': _getString('user_language') ?? 'en',
      'notifications': _getBool('user_notifications') ?? true,
      'currency': _getString('user_currency') ?? 'USD',
    };
  }

  // Cache destinations
  static Future<void> cacheDestinations(List<Destination> destinations) async {
    final destinationsJson = destinations.map((d) => d.toJson()).toList();
    await _setString('cached_destinations', jsonEncode(destinationsJson));
    await _setInt('destinations_cache_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static List<Destination>? getCachedDestinations() {
    final cachedData = _getString('cached_destinations');
    if (cachedData == null) return null;

    try {
      final List<dynamic> destinationsJson = jsonDecode(cachedData);
      return destinationsJson.map((json) => Destination.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  static bool isDestinationsCacheValid({Duration maxAge = const Duration(hours: 1)}) {
    final timestamp = _getInt('destinations_cache_timestamp');
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }

  // Cache travel tips
  static Future<void> cacheTravelTips(List<TravelTip> tips) async {
    final tipsJson = tips.map((t) => t.toJson()).toList();
    await _setString('cached_travel_tips', jsonEncode(tipsJson));
    await _setInt('travel_tips_cache_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static List<TravelTip>? getCachedTravelTips() {
    final cachedData = _getString('cached_travel_tips');
    if (cachedData == null) return null;

    try {
      final List<dynamic> tipsJson = jsonDecode(cachedData);
      return tipsJson.map((json) => TravelTip.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  static bool isTravelTipsCacheValid({Duration maxAge = const Duration(hours: 2)}) {
    final timestamp = _getInt('travel_tips_cache_timestamp');
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }

  // Cache community posts
  static Future<void> cacheCommunityPosts(List<CommunityPost> posts) async {
    final postsJson = posts.map((p) => p.toJson()).toList();
    await _setString('cached_community_posts', jsonEncode(postsJson));
    await _setInt('community_posts_cache_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static List<CommunityPost>? getCachedCommunityPosts() {
    final cachedData = _getString('cached_community_posts');
    if (cachedData == null) return null;

    try {
      final List<dynamic> postsJson = jsonDecode(cachedData);
      return postsJson.map((json) => CommunityPost.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  static bool isCommunityPostsCacheValid({Duration maxAge = const Duration(minutes: 30)}) {
    final timestamp = _getInt('community_posts_cache_timestamp');
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }

  // Cache user itineraries
  static Future<void> cacheUserItineraries(String userId, List<Itinerary> itineraries) async {
    final itinerariesJson = itineraries.map((i) => i.toJson()).toList();
    await _setString('cached_itineraries_$userId', jsonEncode(itinerariesJson));
    await _setInt('itineraries_cache_timestamp_$userId', DateTime.now().millisecondsSinceEpoch);
  }

  static List<Itinerary>? getCachedUserItineraries(String userId) {
    final cachedData = _getString('cached_itineraries_$userId');
    if (cachedData == null) return null;

    try {
      final List<dynamic> itinerariesJson = jsonDecode(cachedData);
      return itinerariesJson.map((json) => Itinerary.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  static bool isUserItinerariesCacheValid(String userId, {Duration maxAge = const Duration(hours: 1)}) {
    final timestamp = _getInt('itineraries_cache_timestamp_$userId');
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }

  // Cache destination reviews
  static Future<void> cacheDestinationReviews(String destinationId, List<Review> reviews) async {
    final reviewsJson = reviews.map((r) => r.toJson()).toList();
    await _setString('cached_reviews_$destinationId', jsonEncode(reviewsJson));
    await _setInt('reviews_cache_timestamp_$destinationId', DateTime.now().millisecondsSinceEpoch);
  }

  static List<Review>? getCachedDestinationReviews(String destinationId) {
    final cachedData = _getString('cached_reviews_$destinationId');
    if (cachedData == null) return null;

    try {
      final List<dynamic> reviewsJson = jsonDecode(cachedData);
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  static bool isDestinationReviewsCacheValid(String destinationId, {Duration maxAge = const Duration(hours: 2)}) {
    final timestamp = _getInt('reviews_cache_timestamp_$destinationId');
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }

  // Offline mode
  static Future<void> setOfflineMode(bool isOffline) async {
    await _setBool('offline_mode', isOffline);
  }

  static bool getOfflineMode() {
    return _getBool('offline_mode') ?? false;
  }

  // Last sync timestamp
  static Future<void> setLastSyncTimestamp() async {
    await _setInt('last_sync_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static DateTime? getLastSyncTimestamp() {
    final timestamp = _getInt('last_sync_timestamp');
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Search history
  static Future<void> addSearchHistory(String query) async {
    final history = getSearchHistory();
    if (!history.contains(query)) {
      history.insert(0, query);
      // Keep only last 10 searches
      if (history.length > 10) {
        history.removeRange(10, history.length);
      }
      await _setStringList('search_history', history);
    }
  }

  static List<String> getSearchHistory() {
    return _getStringList('search_history') ?? [];
  }

  static Future<void> clearSearchHistory() async {
    await _prefs?.remove('search_history');
  }

  // Favorites
  static Future<void> addFavorite(String destinationId) async {
    final favorites = getFavorites();
    if (!favorites.contains(destinationId)) {
      favorites.add(destinationId);
      await _setStringList('favorites', favorites);
    }
  }

  static Future<void> removeFavorite(String destinationId) async {
    final favorites = getFavorites();
    favorites.remove(destinationId);
    await _setStringList('favorites', favorites);
  }

  static List<String> getFavorites() {
    return _getStringList('favorites') ?? [];
  }

  static bool isFavorite(String destinationId) {
    return getFavorites().contains(destinationId);
  }

  // Recently viewed destinations
  static Future<void> addRecentlyViewed(String destinationId) async {
    final recent = getRecentlyViewed();
    recent.remove(destinationId); // Remove if already exists
    recent.insert(0, destinationId); // Add to beginning
    // Keep only last 20
    if (recent.length > 20) {
      recent.removeRange(20, recent.length);
    }
    await _setStringList('recently_viewed', recent);
  }

  static List<String> getRecentlyViewed() {
    return _getStringList('recently_viewed') ?? [];
  }

  static Future<void> clearRecentlyViewed() async {
    await _prefs?.remove('recently_viewed');
  }

  // Clear all cache
  static Future<void> clearAllCache() async {
    final keys = _prefs?.getKeys() ?? {};
    for (final key in keys) {
      if (key.startsWith('cached_') || key.endsWith('_cache_timestamp')) {
        await _prefs?.remove(key);
      }
    }
  }

  // Clear all data
  static Future<void> clearAllData() async {
    await _prefs?.clear();
  }

  // App settings
  static Future<void> setAppSettings({
    bool? firstLaunch,
    String? appVersion,
    bool? analyticsEnabled,
  }) async {
    if (firstLaunch != null) await _setBool('first_launch', firstLaunch);
    if (appVersion != null) await _setString('app_version', appVersion);
    if (analyticsEnabled != null) await _setBool('analytics_enabled', analyticsEnabled);
  }

  static Map<String, dynamic> getAppSettings() {
    return {
      'firstLaunch': _getBool('first_launch') ?? true,
      'appVersion': _getString('app_version') ?? '1.0.0',
      'analyticsEnabled': _getBool('analytics_enabled') ?? true,
    };
  }

  // Network status
  static Future<void> setNetworkStatus(bool isConnected) async {
    await _setBool('network_connected', isConnected);
    await _setInt('network_status_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static bool getNetworkStatus() {
    return _getBool('network_connected') ?? true;
  }

  static DateTime? getNetworkStatusTimestamp() {
    final timestamp = _getInt('network_status_timestamp');
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
