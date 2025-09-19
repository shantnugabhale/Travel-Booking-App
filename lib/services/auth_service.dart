import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelapp/models/user.dart';
import 'package:travelapp/services/database_service.dart';

class AuthService {
  static final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  static firebase_auth.User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  static Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  static Future<firebase_auth.User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final firebase_auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebase_auth.User? user = result.user;
      
      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);
        
        // Create user profile in Firestore
        final userProfile = User(
          id: user.uid,
          email: user.email!,
          name: name,
          avatar: user.photoURL ?? '',
          bio: '',
          interests: [],
          visitedDestinations: [],
          savedItineraries: [],
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
          travelStyle: '',
          totalTrips: 0,
          totalReviews: 0,
        );
        
        await DatabaseService.createUserProfile(userProfile);
        
        // Send email verification
        await sendEmailVerification();
      }

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  static Future<firebase_auth.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebase_auth.User? user = result.user;
      
      if (user != null) {
        // Update last login
        final userProfile = await DatabaseService.getUserProfile(user.uid);
        if (userProfile != null) {
          final updatedProfile = User(
            id: userProfile.id,
            email: userProfile.email,
            name: userProfile.name,
            avatar: userProfile.avatar,
            bio: userProfile.bio,
            interests: userProfile.interests,
            visitedDestinations: userProfile.visitedDestinations,
            savedItineraries: userProfile.savedItineraries,
            createdAt: userProfile.createdAt,
            lastLogin: DateTime.now(),
            travelStyle: userProfile.travelStyle,
            totalTrips: userProfile.totalTrips,
            totalReviews: userProfile.totalReviews,
          );
          await DatabaseService.updateUserProfile(updatedProfile);
        }
      }

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with Google
  static Future<firebase_auth.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebase_auth.UserCredential result = await _auth.signInWithCredential(credential);
      final firebase_auth.User? user = result.user;

      if (user != null) {
        // Check if user profile exists
        final existingProfile = await DatabaseService.getUserProfile(user.uid);
        
        if (existingProfile == null) {
          // Create new user profile
          final userProfile = User(
            id: user.uid,
            email: user.email!,
            name: user.displayName ?? 'User',
            avatar: user.photoURL ?? '',
            bio: '',
            interests: [],
            visitedDestinations: [],
            savedItineraries: [],
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
            travelStyle: '',
            totalTrips: 0,
            totalReviews: 0,
          );
          
          await DatabaseService.createUserProfile(userProfile);
        } else {
          // Update last login
          final updatedProfile = User(
            id: existingProfile.id,
            email: existingProfile.email,
            name: existingProfile.name,
            avatar: user.photoURL ?? existingProfile.avatar,
            bio: existingProfile.bio,
            interests: existingProfile.interests,
            visitedDestinations: existingProfile.visitedDestinations,
            savedItineraries: existingProfile.savedItineraries,
            createdAt: existingProfile.createdAt,
            lastLogin: DateTime.now(),
            travelStyle: existingProfile.travelStyle,
            totalTrips: existingProfile.totalTrips,
            totalReviews: existingProfile.totalReviews,
          );
          await DatabaseService.updateUserProfile(updatedProfile);
        }
      }

      return user;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Send password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Send email verification
  static Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Check if email is verified
  static bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Reload user to get updated email verification status
  static Future<void> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
    } catch (e) {
      throw Exception('Failed to reload user: $e');
    }
  }

  // Update password
  static Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Re-authenticate user
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update email
  static Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Re-authenticate user
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      
      await user.reauthenticateWithCredential(credential);
      await user.updateEmail(newEmail);
      
      // Send verification email for new email
      await sendEmailVerification();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Delete account
  static Future<void> deleteAccount(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Re-authenticate user
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      
      await user.reauthenticateWithCredential(credential);
      
      // Delete user data from Firestore
      await DatabaseService.deleteUserData(user.uid);
      
      // Delete user account
      await user.delete();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Handle Firebase Auth exceptions
  static String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'invalid-credential':
        return 'The credential provided is invalid.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  // Get user profile
  static Future<User?> getUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;
      
      return await DatabaseService.getUserProfile(user.uid);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  // Update user profile
  static Future<void> updateUserProfile(User user) async {
    try {
      await DatabaseService.updateUserProfile(user);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }
}
