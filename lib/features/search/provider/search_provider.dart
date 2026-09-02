import 'package:flutter/material.dart';
import 'package:news_wave/core/network/api_response.dart';
import 'package:news_wave/features/news/services/news_service.dart';

import '../../news/models/category_news_model.dart';
class SearchProvider with ChangeNotifier{
final NewsService _newsService = NewsService();
ApiResponse<CategoryNewsModel> _searchResponse =const ApiResponse.idle();
ApiResponse<CategoryNewsModel> get searchResponse =>_searchResponse;
final TextEditingController searchController =TextEditingController();
final FocusNode searchFocus= FocusNode();
/*searchNews start here*/
  Future<void> searchNews() async {
    final query= searchController.text.trim();
    if(query.isEmpty)return;
    _searchResponse = const ApiResponse.loading();
    notifyListeners();
    try{
final response = await _newsService.searchNews(query);
_searchResponse= ApiResponse.completed(response);
    }
    catch(e){
      _searchResponse = ApiResponse.error(e.toString(),);
    }
    notifyListeners();
  }
  /*searchNews end here*/
  /*clearSearch start here*/
  void clearSearch(){
    searchController.clear();
    _searchResponse= const ApiResponse.idle();
    notifyListeners();
  }
  /*clearSearch end here*/
@override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}