import 'package:dartz/dartz.dart';
import 'package:unistay/core/errors/failures.dart';
import 'package:unistay/features/auth/data/models/user_model.dart';

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  const AuthRepository();

  /// Sign in with email and password
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  });

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Get current authenticated user
  Future<Either<Failure, UserModel>> getCurrentUser();

  /// Reset password
  Future<Either<Failure, void>> resetPassword({required String email});

  /// Update user profile
  Future<Either<Failure, UserModel>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  });

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Stream of auth state changes
  Stream<UserModel?> get authStateChanges;
}
