import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:repaint_api_client/repaint_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_dio/sentry_dio.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
RepaintApiClient apiClient(ApiClientRef ref) {
  final client = RepaintApiClient(
    basePathOverride: dotenv.env['API_BASE_URL'],
    interceptors: [
      LogInterceptor(requestBody: true, responseBody: true),
      InterceptorsWrapper(
        onError: (error, handler) {
          // ignore: avoid_manual_providers_as_generated_provider_dependency
          ref.read(networkErrorProvider.notifier).set(error);
          return handler.next(error);
        },
      ),
    ],
  );

  client.dio.addSentry();

  return client;
}

@Riverpod(keepAlive: true, dependencies: [])
class NetworkError extends _$NetworkError {
  @override
  DioException? build() {
    return null;
  }

  void set(DioException? error) {
    state = error;
  }
}
