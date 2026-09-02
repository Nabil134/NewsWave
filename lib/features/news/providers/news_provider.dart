import 'package:flutter/cupertino.dart';
import 'package:news_wave/core/network/api_response.dart';
import 'package:news_wave/features/news/services/news_service.dart';

import '../models/category_news_model.dart';

class NewsProvider with ChangeNotifier{
  final NewsService _newsService=NewsService();
  ApiResponse<CategoryNewsModel> _categoryNewsResponse =const  ApiResponse.idle();
  ApiResponse<CategoryNewsModel> get categoryNewsResponse=>_categoryNewsResponse;
  /*getCategoryNews start here*/
Future<void> getCategoryNews(String category) async{
  _categoryNewsResponse = const ApiResponse.loading();
  notifyListeners();
  try {
    final response = await _newsService.getCategoryNews(category);
    _categoryNewsResponse = ApiResponse.completed(response);
  }
  catch(e){
_categoryNewsResponse = ApiResponse.error(e.toString(),);
  }
  notifyListeners();
}
/*getCategoryNews end here*/
}