import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unistay/core/theme/app_theme.dart';
import 'package:unistay/core/utils/extensions.dart';
import 'package:unistay/features/auth/presentation/screens/login_screen.dart';
import 'package:unistay/features/home/presentation/screens/home_screen.dart';
import 'package:unistay/features/profile/presentation/screens/profile_screen.dart';
import 'package:unistay/features/search/presentation/screens/search_screen.dart';
import 'package:unistay/features/details/presentation/screens/hostel_details_screen.dart';
import 'package:unistay/features/booking/presentation/screens/booking_screen.dart';

/// Main application widget
class UniStayApp extends ConsumerWidget {
  const UniStayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual auth state provider
    final isAuthenticated = false;

    return MaterialApp(
      title: 'UniStay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: isAuthenticated ? '/home' : '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

/// Route configuration and generation
class RouteGenerator {
  RouteGenerator._();

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String search = '/search';
  static const String hostelDetails = '/hostel-details';
  static const String booking = '/booking';
  static const String profile = '/profile';
  static const String bookingsHistory = '/bookings-history';
  static const String settings = '/settings';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildPageRoute(const LoginScreen(), settings);
      case register:
        return _buildPageRoute(const RegisterScreen(), settings);
      case forgotPassword:
        return _buildPageRoute(const ForgotPasswordScreen(), settings);
      case home:
        return _buildPageRoute(const HomeScreen(), settings);
      case search:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPageRoute(
          SearchScreen(
            initialQuery: args?['query'] as String?,
            initialLocation: args?['location'] as String?,
          ),
          settings,
        );
      case hostelDetails:
        final hostelId = settings.arguments as String?;
        if (hostelId == null) {
          return _buildPageRoute(const HostelDetailsScreen(hostelId: ''), settings);
        }
        return _buildPageRoute(HostelDetailsScreen(hostelId: hostelId), settings);
      case booking:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPageRoute(
          BookingScreen(
            hostelId: args?['hostelId'] as String? ?? '',
            checkIn: args?['checkIn'] as DateTime?,
            checkOut: args?['checkOut'] as DateTime?,
            guests: args?['guests'] as int? ?? 1,
          ),
          settings,
        );
      case profile:
        return _buildPageRoute(const ProfileScreen(), settings);
      default:
        return _buildPageRoute(const LoginScreen(), settings);
    }
  }

  static PageRouteBuilder<dynamic> _buildPageRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.02);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

// Placeholder screens for compilation - will be replaced with actual implementations

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('Register Screen')),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: const Center(child: Text('Forgot Password Screen')),
    );
  }
}
