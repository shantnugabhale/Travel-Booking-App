import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:travelapp/models/destination.dart';
import 'package:travelapp/models/itinerary.dart';
import 'package:travelapp/models/review.dart';
import 'package:travelapp/models/travel_tip.dart';
import 'package:travelapp/models/community_post.dart';
import 'package:travelapp/models/user.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  // Collections
  static const String _destinationsCollection = 'destinations';
  static const String _itinerariesCollection = 'itineraries';
  static const String _reviewsCollection = 'reviews';
  static const String _travelTipsCollection = 'travel_tips';
  static const String _communityPostsCollection = 'community_posts';
  static const String _usersCollection = 'users';

  // User Management
  static Future<void> createUserProfile(User user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  static Future<User?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .get();
      
      if (doc.exists) {
        return User.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  static Future<void> updateUserProfile(User user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  static Future<void> deleteUserData(String userId) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete user data: $e');
    }
  }

  // Destinations
  static Future<List<Destination>> getDestinations() async {
    try {
      final querySnapshot = await _firestore
          .collection(_destinationsCollection)
          .orderBy('averageRating', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Destination.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get destinations: $e');
    }
  }

  static Future<Destination?> getDestination(String destinationId) async {
    try {
      final doc = await _firestore
          .collection(_destinationsCollection)
          .doc(destinationId)
          .get();
      
      if (doc.exists) {
        return Destination.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get destination: $e');
    }
  }

  static Future<List<Destination>> searchDestinations(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection(_destinationsCollection)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();
      
      return querySnapshot.docs
          .map((doc) => Destination.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search destinations: $e');
    }
  }

  // Itineraries
  static Future<List<Itinerary>> getUserItineraries(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_itinerariesCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Itinerary.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user itineraries: $e');
    }
  }

  static Future<void> saveItinerary(Itinerary itinerary) async {
    try {
      await _firestore
          .collection(_itinerariesCollection)
          .doc(itinerary.id)
          .set(itinerary.toJson());
    } catch (e) {
      throw Exception('Failed to save itinerary: $e');
    }
  }

  static Future<void> deleteItinerary(String itineraryId) async {
    try {
      await _firestore
          .collection(_itinerariesCollection)
          .doc(itineraryId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete itinerary: $e');
    }
  }

  // Reviews
  static Future<List<Review>> getDestinationReviews(String destinationId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_reviewsCollection)
          .where('destinationId', isEqualTo: destinationId)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Review.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get reviews: $e');
    }
  }

  static Future<void> addReview(Review review) async {
    try {
      await _firestore
          .collection(_reviewsCollection)
          .doc(review.id)
          .set(review.toJson());
      
      // Update destination average rating
      await _updateDestinationRating(review.destinationId);
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  static Future<void> _updateDestinationRating(String destinationId) async {
    try {
      final reviewsSnapshot = await _firestore
          .collection(_reviewsCollection)
          .where('destinationId', isEqualTo: destinationId)
          .get();
      
      if (reviewsSnapshot.docs.isNotEmpty) {
        double totalRating = 0;
        for (var doc in reviewsSnapshot.docs) {
          totalRating += doc.data()['rating'] ?? 0;
        }
        double averageRating = totalRating / reviewsSnapshot.docs.length;
        
        await _firestore
            .collection(_destinationsCollection)
            .doc(destinationId)
            .update({
          'averageRating': averageRating,
          'reviewCount': reviewsSnapshot.docs.length,
        });
      }
    } catch (e) {
      throw Exception('Failed to update destination rating: $e');
    }
  }

  // Travel Tips
  static Future<List<TravelTip>> getTravelTips({String? category}) async {
    try {
      Query query = _firestore
          .collection(_travelTipsCollection)
          .orderBy('createdAt', descending: true);
      
      if (category != null && category != 'All') {
        query = query.where('category', isEqualTo: category);
      }
      
      final querySnapshot = await query.get();
      
      return querySnapshot.docs
          .map((doc) => TravelTip.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get travel tips: $e');
    }
  }

  static Future<List<TravelTip>> getFeaturedTravelTips() async {
    try {
      final querySnapshot = await _firestore
          .collection(_travelTipsCollection)
          .where('isFeatured', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();
      
      return querySnapshot.docs
          .map((doc) => TravelTip.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get featured travel tips: $e');
    }
  }

  // Community Posts
  static Future<List<CommunityPost>> getCommunityPosts({String? category}) async {
    try {
      Query query = _firestore
          .collection(_communityPostsCollection)
          .orderBy('createdAt', descending: true);
      
      if (category != null && category != 'All') {
        query = query.where('category', isEqualTo: category);
      }
      
      final querySnapshot = await query.get();
      
      return querySnapshot.docs
          .map((doc) => CommunityPost.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get community posts: $e');
    }
  }

  static Future<void> addCommunityPost(CommunityPost post) async {
    try {
      await _firestore
          .collection(_communityPostsCollection)
          .doc(post.id)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to add community post: $e');
    }
  }

  static Future<void> likePost(String postId, String userId) async {
    try {
      final postRef = _firestore.collection(_communityPostsCollection).doc(postId);
      
      await _firestore.runTransaction((transaction) async {
        final postDoc = await transaction.get(postRef);
        
        if (postDoc.exists) {
          final postData = postDoc.data()!;
          final likes = List<String>.from(postData['likes'] ?? []);
          
          if (likes.contains(userId)) {
            likes.remove(userId);
          } else {
            likes.add(userId);
          }
          
          transaction.update(postRef, {
            'likes': likes,
            'likesCount': likes.length,
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to like post: $e');
    }
  }

  static Future<void> addComment(String postId, Comment comment) async {
    try {
      final postRef = _firestore.collection(_communityPostsCollection).doc(postId);
      
      await _firestore.runTransaction((transaction) async {
        final postDoc = await transaction.get(postRef);
        
        if (postDoc.exists) {
          final postData = postDoc.data()!;
          final comments = List<Map<String, dynamic>>.from(postData['commentList'] ?? []);
          
          comments.add(comment.toJson());
          
          transaction.update(postRef, {
            'commentList': comments,
            'comments': comments.length,
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  // Real-time listeners
  static Stream<List<CommunityPost>> getCommunityPostsStream({String? category}) {
    Query query = _firestore
        .collection(_communityPostsCollection)
        .orderBy('createdAt', descending: true);
    
    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CommunityPost.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static Stream<List<Review>> getDestinationReviewsStream(String destinationId) {
    return _firestore
        .collection(_reviewsCollection)
        .where('destinationId', isEqualTo: destinationId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Review.fromJson(doc.data()))
          .toList();
    });
  }

  // Utility methods
  static Future<void> initializeSampleData() async {
    try {
      // Add sample destinations
      final destinations = [
        Destination(
          id: 'tokyo',
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
          id: 'santorini',
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
      ];

      for (final destination in destinations) {
        await _firestore
            .collection(_destinationsCollection)
            .doc(destination.id)
            .set(destination.toJson());
      }
    } catch (e) {
      throw Exception('Failed to initialize sample data: $e');
    }
  }
}
