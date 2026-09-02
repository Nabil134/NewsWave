import 'package:dio/dio.dart';
import 'package:news_wave/core/network/dio_interceptor.dart';

class DioClient{
  DioClient._();
  static Dio create(
  {
    required String baseUrl,
}
      ){
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    )..interceptors.add(DioInterceptor(),);

  }
}