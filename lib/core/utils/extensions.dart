import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension BuildContextExtension on BuildContext {
  /// Get the theme data
  ThemeData get theme => Theme.of(this);

  /// Get the text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get the color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get the media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if device is a tablet
  bool get isTablet => screenWidth >= 600;

  /// Check if device is in landscape mode
  bool get isLandscape => screenWidth > screenHeight;

  /// Check if device is in portrait mode
  bool get isPortrait => screenHeight > screenWidth;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// Get bottom safe area padding (for keyboard, home indicator)
  double get bottomSafeAreaPadding => MediaQuery.of(this).padding.bottom;

  /// Get top safe area padding (for notch, status bar)
  double get topSafeAreaPadding => MediaQuery.of(this).padding.top;

  /// Show a snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// Show an error snackbar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Navigate with replacement
  Future<T?> navigateReplacement<T>(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Navigate and push
  Future<T?> navigatePush<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop the current route
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

/// Extension methods for String
extension StringExtension on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize all words
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is a valid phone number (basic validation)
  bool get isValidPhone {
    return RegExp(r'^\+?[\d\s-]{8,}$').hasMatch(this);
  }

  /// Mask email for privacy
  String get maskedEmail {
    if (!contains('@') || length < 5) return this;
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return '*@$domain';
    }
    
    return '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}@$domain';
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Check if string is null or empty
  bool get isNullOrEmpty => trim().isEmpty;

  /// Check if string is not null or empty
  bool get isNotNullOrEmpty => trim().isNotEmpty;
}

/// Extension methods for DateTime
extension DateTimeExtension on DateTime {
  /// Format date as "MMM dd, yyyy"
  String get formattedDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[month - 1]} ${day.toString().padLeft(2, '0')}, $year';
  }

  /// Format time as "hh:mm AM/PM"
  String get formattedTime {
    final hour = this.hour == 0 ? 12 : (this.hour > 12 ? this.hour - 12 : this.hour);
    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} $period';
  }

  /// Format datetime as "MMM dd, yyyy hh:mm AM/PM"
  String get formattedDateTime => '$formattedDate $formattedTime';

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Get relative time string
  String get relativeTime {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() > 1 ? 's' : ''} ago';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Get days difference from now
  int get daysFromNow => DateTime.now().difference(this).inDays;

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

/// Extension methods for num (int/double)
extension NumExtension on num {
  /// Format as currency
  String get asCurrency {
    return '\$${toStringAsFixed(2)}';
  }

  /// Format as percentage
  String get asPercentage {
    return '${toStringAsFixed(0)}%';
  }

  /// Convert to duration in seconds
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to duration in minutes
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to duration in hours
  Duration get hours => Duration(hours: toInt());

  /// Convert to duration in days
  Duration get days => Duration(days: toInt());
}

/// Extension methods for List
extension ListExtension<T> on List<T> {
  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Check if list has only one element
  bool get hasOneElement => length == 1;

  /// Get elements except the first one
  List<T> get skipFirst => length > 1 ? sublist(1) : [];

  /// Get elements except the last one
  List<T> get skipLast => length > 1 ? sublist(0, length - 1) : [];
}
