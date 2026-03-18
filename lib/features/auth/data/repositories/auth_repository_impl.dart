import 'package:dartz/dartz.dart';
import 'package:unistay/core/errors/exceptions.dart';
import 'package:unistay/core/errors/failures.dart';
import 'package:unistay/core/network/network_config.dart';
import 'package:unistay/core/utils/logger.dart';
import 'package:unistay/features/auth/data/models/user_model.dart';
import 'package:unistay/features/auth/data/repositories/auth_repository.dart';

/// Implementation of AuthRepository using Dio for network calls
class AuthRepositoryImpl implements AuthRepository {
  final DioClient _dioClient;
  final LocalAuthDataSource _localDataSource;

  const AuthRepositoryImpl({
    required DioClient dioClient,
    required LocalAuthDataSource localDataSource,
  })  : _dioClient = dioClient,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        final token = response.data['token'];
        
        // Store auth tokens locally
        await _localDataSource.saveAuthToken(token);
        await _localDataSource.saveUser(user);

        return Right(user);
      } else {
        return Left(ServerFailure(
          message: response.data['message'] ?? 'Sign in failed',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      Logger.error('Sign in error', exception: e);
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Sign in unknown error', exception: e);
      return Left(UnknownFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    try {
      final response = await _dioClient.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 201) {
        final user = UserModel.fromJson(response.data['user']);
        final token = response.data['token'];
        
        await _localDataSource.saveAuthToken(token);
        await _localDataSource.saveUser(user);

        return Right(user);
      } else {
        return Left(ServerFailure(
          message: response.data['message'] ?? 'Registration failed',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      Logger.error('Register error', exception: e);
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Register unknown error', exception: e);
      return Left(UnknownFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      Logger.error('Sign out error', exception: e);
      return Left(CacheFailure(message: 'Failed to sign out'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final user = await _localDataSource.getUser();
      if (user != null) {
        return Right(user);
      } else {
        return Left(AuthFailure(message: 'No authenticated user found'));
      }
    } catch (e) {
      Logger.error('Get current user error', exception: e);
      return Left(CacheFailure(message: 'Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      final response = await _dioClient.post(
        '/auth/reset-password',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.data['message'] ?? 'Password reset failed',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      Logger.error('Reset password error', exception: e);
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Reset password unknown error', exception: e);
      return Left(UnknownFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    try {
      final response = await _dioClient.patch(
        '/auth/profile',
        data: {
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
        },
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        await _localDataSource.saveUser(user);
        return Right(user);
      } else {
        return Left(ServerFailure(
          message: response.data['message'] ?? 'Profile update failed',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      Logger.error('Update profile error', exception: e);
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Update profile unknown error', exception: e);
      return Left(UnknownFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _localDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Stream<UserModel?> get authStateChanges async* {
    // This would typically listen to auth state changes from Firebase or similar
    // For now, we emit the current user once
    final result = await getCurrentUser();
    yield result.fold((_) => null, (user) => user);
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(message: 'Connection timed out. Please try again.');
      case DioExceptionType.badResponse:
        return ServerFailure(
          message: e.response?.data['message'] ?? 'Server error',
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return UnknownFailure(message: 'Request was cancelled');
      default:
        return NetworkFailure(message: 'Network error. Please check your connection.');
    }
  }
}

/// Abstract class for local authentication data source
abstract class LocalAuthDataSource {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearAuthData();
}

/// Dio client wrapper for auth operations
class DioClient {
  final dio = NetworkConfig.createDio();

  Future<dynamic> post(String path, {dynamic data}) async {
    final response = await dio.post(path, data: data);
    return response;
  }

  Future<dynamic> patch(String path, {dynamic data}) async {
    final response = await dio.patch(path, data: data);
    return response;
  }

  Future<dynamic> get(String path) async {
    final response = await dio.get(path);
    return response;
  }
}
