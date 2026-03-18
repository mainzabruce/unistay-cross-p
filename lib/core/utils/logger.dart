import 'package:flutter/foundation.dart';

/// Logger utility for the application
class Logger {
  Logger._();

  static const String _prefix = '🏠 UniStay';

  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix $tagStr: $message');
    }
  }

  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ℹ️ $tagStr: $message');
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ⚠️ $tagStr: $message');
    }
  }

  static void error(String message, {String? tag, Object? exception, StackTrace? stackTrace}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ❌ $tagStr: $message');
      if (exception != null) {
        debugPrint('Exception: $exception');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  static void success(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ✅ $tagStr: $message');
    }
  }

  static void network(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[Network][$tag]' : '[Network]';
      debugPrint('$_prefix 🌐 $tagStr: $message');
    }
  }

  static void database(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[Database][$tag]' : '[Database]';
      debugPrint('$_prefix 💾 $tagStr: $message');
    }
  }
}
