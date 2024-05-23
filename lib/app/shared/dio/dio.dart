import 'package:dio/dio.dart';

final Dio dio = DioHelper.getDio(baseUrl: 'https://dog.ceo/api/');

mixin DioHelper {
  static Dio? _dio;

  static const Duration maxApiCacheAge = Duration(hours: 1);
  static const Duration maxApiStaleAge = Duration(hours: 3);

  static Dio getDio({required String baseUrl}) {
    _dio ??= Dio(BaseOptions(
      contentType: 'application/json; charset=utf-8',
      baseUrl: baseUrl,
    ))
      ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    return _dio!;
  }
}
