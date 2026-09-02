abstract class BaseApiService{
  Future<dynamic> get(String endPoint, {
    Map<String,dynamic>? queryParameters,
  });
}