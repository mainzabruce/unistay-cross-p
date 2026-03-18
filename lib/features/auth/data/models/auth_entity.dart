import 'package:equatable/equatable.dart';

/// Authentication entity containing user credentials and token
class AuthEntity extends Equatable {
  final String userId;
  final String email;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const AuthEntity({
    required this.userId,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// Check if token is expired
  bool get isTokenExpired => DateTime.now().isAfter(expiresAt);

  /// Check if token is about to expire (within 5 minutes)
  bool get isTokenExpiringSoon {
    return DateTime.now()
        .add(const Duration(minutes: 5))
        .isAfter(expiresAt);
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        accessToken,
        refreshToken,
        expiresAt,
      ];

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }
}
