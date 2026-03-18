import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';
import 'package:unistay/core/utils/extensions.dart';
import 'package:unistay/shared/widgets/common_widgets.dart';

/// Authentication state notifier for managing login/register flows
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial());

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthState.loading();
    
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 2));
      
      state = AuthState.authenticated(
        user: UserEntity(
          id: '1',
          email: email,
          firstName: 'John',
          lastName: 'Doe',
        ),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AuthState.loading();
    
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 2));
      
      state = AuthState.authenticated(
        user: UserEntity(
          id: '1',
          email: email,
          firstName: firstName,
          lastName: lastName,
        ),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthState.initial();
  }

  void clearError() {
    if (state.status == AuthStatus.error) {
      state = const AuthState.initial();
    }
  }
}

/// User entity
class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
  });

  String get fullName => '$firstName $lastName';
  
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }
}

/// Authentication status enum
enum AuthStatus { initial, loading, authenticated, error }

/// Authentication state class
class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? error;

  const AuthState._({
    required this.status,
    this.user,
    this.error,
  });

  const AuthState.initial() : this._(status: AuthStatus.initial);
  const AuthState.loading() : this._(status: AuthStatus.loading);
  const AuthState.authenticated({required UserEntity user})
      : this._(status: AuthStatus.authenticated, user: user);
  const AuthState.error(String error)
      : this._(status: AuthStatus.error, error: error);
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
