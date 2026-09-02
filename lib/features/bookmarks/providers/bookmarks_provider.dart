import 'package:flutter/material.dart';
import 'package:news_wave/core/services/bookmark_service.dart';
import '../../news/models/category_news_model.dart';
class BookmarksProvider with ChangeNotifier{
List<Articles> _bookmarks=[];
bool _isLoading=false;
List<Articles> get bookmarks=>_bookmarks;
bool get isLoading=>_isLoading;
/*loadBookMarks start here*/
Future<void> loadBookMarks() async{
  _isLoading=true;
  notifyListeners();
  _bookmarks =await BookmarkService.getBookmarks();
  _isLoading=false;
  notifyListeners();
}
/*loadBookMarks end here*/
/*isBookmarked start here*/
bool isBookmarked(String? url){
if (url==null) return false;
return _bookmarks.any((e) => e.url==url);
}
/*isBookmarked end here*/
  /*toggleBookmarks start here*/
  Future<void> toggleBookmarks(Articles article)async{
    final bool exists = isBookmarked(article.url);
    if(exists){
      await BookmarkService.removeBookmarks(article.url??"");
      _bookmarks.removeWhere((e) => e.url==article.url);
    }
    else{
      await BookmarkService.addBookmarks(article);
      _bookmarks.insert(0, article);
    }
notifyListeners();
  }
  /*toggleBookmarks end here*/
/*clearAllBookmarks start here*/
Future<void> clearAllBookmarks()async{
  await BookmarkService.clearBookmarks();
  _bookmarks=[];
  notifyListeners();
}
/*clearAllBookmarks end here*/
}