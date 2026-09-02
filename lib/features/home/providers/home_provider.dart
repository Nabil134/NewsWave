import 'package:flutter/material.dart';
import 'package:news_wave/features/news/providers/news_provider.dart';

class HomeProvider with ChangeNotifier{
late TabController tabController;
int _tabIndex=0;
int get tabIndex=>_tabIndex;
/*categories start here*/
final List<String> categories=[
  "General",
  'Business',
  'Sports',
  'Technology',
];
/*categories end here*/
  /*categories start here*/
  final List<String> apiCategories=[
    'general',
    'business',
    'sports',
    'technology',
  ];
/*categories end here*/
/*initializeTabController start here*/
  void initializeTabController(TickerProvider vsync,NewsProvider newsProvider){
tabController =TabController(length: categories.length, vsync: vsync);
tabController.addListener(() {
  if(_tabIndex != tabController.index){
    _tabIndex=tabController.index;
    notifyListeners();
    newsProvider.getCategoryNews(apiCategories[_tabIndex]);
  }
});
  }
  /*initializeTabController end here*/
  /*_onTapChange start here*/
  void _onTapChange(){
    if(_tabIndex != tabController.index){
      _tabIndex= tabController.index;
      notifyListeners();
    }
  }
  /*_onTapChange end here*/
  /*_onTapChange start here*/
  void disposeTabController(){
    tabController.removeListener(_onTapChange);
   tabController.dispose();
  }
  /*_onTapChange end here*/
@override
  void dispose() {
  tabController.removeListener(_onTapChange);
    tabController.dispose();
    super.dispose();
  }
}