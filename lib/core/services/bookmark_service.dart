import 'dart:convert';
import 'package:news_wave/features/news/models/category_news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService{
  BookmarkService._();
  static const String _key="bookmarks";
  /*getBookmarks start here*/
static Future<List<Articles>> getBookmarks() async{
  final prefs = await SharedPreferences.getInstance();
  final List<String> jsonList=  prefs.getStringList(_key)??[];
  return jsonList.map((json) => Articles.fromJson(jsonDecode(json))).toList();

}
/*getBookmarks end here*/
  /*addBookmarks start here*/
  static Future<void> addBookmarks(Articles articles) async{
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList=  prefs.getStringList(_key)??[];
    // ✅ check not already saved
    final exists= jsonList.any((json){
final map =jsonDecode(json);
return map["url"]==articles.url;
    });
if(!exists){
jsonList.add(jsonEncode(articles.toJson()));
await prefs.setStringList(_key, jsonList);
}
  }
/*addBookmarks end here*/
  /*removeBookmarks start here*/
  static Future<void> removeBookmarks(String url) async{
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList=  prefs.getStringList(_key)??[];
    jsonList.removeWhere((json){
      final map= jsonDecode(json);
      return map["url"]==url;
    });
await prefs.setStringList(_key, jsonList);
  }
/*removeBookmarks end here*/
/*isBookmarked start here*/
static Future<bool> isBookmarked(String? url) async{
  final prefs = await SharedPreferences.getInstance();
  final List<String> jsonList=  prefs.getStringList(_key)??[];
  return jsonList.any((json){
    final map = jsonDecode(json);
    return map["url"]==url;
  });
}
/*isBookmarked end here*/
/*clearBookmarks start here*/
static Future<void> clearBookmarks() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_key);
}
/*clearBookmarks end here*/
}