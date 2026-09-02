import 'package:news_wave/core/network/api_config.dart';
import 'package:news_wave/core/network/api_endpoints.dart';
import 'package:news_wave/core/network/network_api_service.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';

class NewsService{
  final NetworkApiService _apiService;
  NewsService():_apiService=NetworkApiService(
    baseUrl: ApiEndPoints.baseUrl,
  );
  /*getCategoryNews start here*/
Future<CategoryNewsModel> getCategoryNews(String category) async{
  final response = await _apiService.get(ApiEndPoints.topHeadlines,
    queryParameters:{
    'country':'us',
    'category':category,
     'apiKey':ApiConfig.apiKey,
    },
  );
return CategoryNewsModel.fromJson(response);
}
/*getCategoryNews end here*/
/*searchNews start here*/
Future<CategoryNewsModel> searchNews(String query) async {
  final response= await _apiService.get(ApiEndPoints.everything,
    queryParameters:{
    'q':query,
      'apiKey':ApiConfig.apiKey,
      'language':'en',
      'sortBy':'publishedAt',
    },
  );
  return CategoryNewsModel.fromJson(response);
}
/*searchNews end here*/

}