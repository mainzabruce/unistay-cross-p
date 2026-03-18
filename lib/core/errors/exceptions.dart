/// Custom exception classes for the application

import 'package:unistay/core/errors/failures.dart';

/// Base exception class
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message (statusCode: $statusCode)';

  Failure toFailure() {
    return UnknownFailure(message: message, statusCode: statusCode);
  }
}

/// Authentication exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => AuthFailure(message: message, statusCode: statusCode);
}

/// Network exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => NetworkFailure(message: message, statusCode: statusCode);
}

/// Server exceptions
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => ServerFailure(message: message, statusCode: statusCode);
}

/// Cache exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => CacheFailure(message: message, statusCode: statusCode);
}

/// Validation exceptions
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => ValidationFailure(message: message, statusCode: statusCode);
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.statusCode = 404,
    super.originalError,
  });

  @override
  Failure toFailure() => NotFoundFailure(message: message, statusCode: statusCode);
}

/// Permission denied exceptions
class PermissionDeniedException extends AppException {
  const PermissionDeniedException({
    required super.message,
    super.statusCode = 403,
    super.originalError,
  });

  @override
  Failure toFailure() => PermissionDeniedFailure(message: message, statusCode: statusCode);
}

/// Timeout exceptions
class TimeoutException extends AppException {
  const TimeoutException({
    required super.message,
    super.statusCode,
    super.originalError,
  });

  @override
  Failure toFailure() => TimeoutFailure(message: message, statusCode: statusCode);
}
