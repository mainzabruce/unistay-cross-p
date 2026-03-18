/// Core error types for the application

import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Authentication related failures
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.statusCode});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.statusCode});
}

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure({required super.message, super.statusCode});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.statusCode});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.statusCode});
}
