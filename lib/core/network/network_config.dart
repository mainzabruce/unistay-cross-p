import 'package:dio/dio.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/utils/logger.dart';

/// Network configuration and Dio client setup
class NetworkConfig {
  NetworkConfig._();

  // Base URL - Replace with actual API endpoint
  static const String baseUrl = 'https://api.unistay.example.com';
  
  // Connection timeout in seconds
  static const int connectTimeout = 30;
  
  // Receive timeout in seconds
  static const int receiveTimeout = 30;

  /// Create and configure Dio instance
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: connectTimeout),
        receiveTimeout: const Duration(seconds: receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // Add interceptors
    dio.interceptors.add(_LoggingInterceptor());
    dio.interceptors.add(_AuthInterceptor());

    return dio;
  }
}

/// Logging interceptor for network requests
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.network(
      '''
REQUEST[${options.method}]
PATH: ${options.uri.path}
HEADERS: ${options.headers}
DATA: ${options.data}
''',
      tag: 'DIO',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.network(
      '''
RESPONSE[${response.statusCode}]
PATH: ${response.requestOptions.uri.path}
DATA: ${response.data}
''',
      tag: 'DIO',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      '''
ERROR[${err.response?.statusCode}]
PATH: ${err.requestOptions.uri.path}
MESSAGE: ${err.message}
''',
      tag: 'DIO',
      exception: err,
    );
    super.onError(err, handler);
  }
}

/// Authentication interceptor for adding tokens to requests
class _AuthInterceptor extends Interceptor {
  String? _authToken;

  void setAuthToken(String? token) {
    _authToken = token;
  }

  String? get authToken => _authToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authToken != null && _authToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_authToken';
    }
    super.onRequest(options, handler);
  }
}

/// Singleton instance of auth interceptor for token management
final authInterceptor = _AuthInterceptor();
