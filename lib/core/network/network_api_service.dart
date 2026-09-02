import 'package:dio/dio.dart';
import 'package:news_wave/core/network/base_api_service.dart';
import 'package:news_wave/core/network/dio_client.dart';
import 'package:news_wave/core/network/errors/api_exception.dart';
import 'package:news_wave/core/network/network_info.dart';

class NetworkApiService implements BaseApiService{
  late final Dio _dio;
  final String baseUrl;
  NetworkApiService({ required this.baseUrl}) {
    _dio = DioClient.create(baseUrl: baseUrl);
  }
  @override
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? queryParameters}) async {
    if(!NetworkInfo.isConnected){
      throw Exception("No Internet Connected");
    }
    try{
      final response = await _dio.get(endPoint,queryParameters: queryParameters);
      return response.data;
    }
    on DioException catch(e){
throw Exception(ApiException.getMessage(e),);
    }
  }
}