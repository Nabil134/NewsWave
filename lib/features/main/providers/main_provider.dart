import 'package:flutter/cupertino.dart';
import 'package:news_wave/features/bookmarks/presentations/bookmarks_screen.dart';
import 'package:news_wave/features/home/presentation/home_screen.dart';
import 'package:news_wave/features/profile/presentation/profile_screen.dart';

class MainProvider with ChangeNotifier{
int _currentIndex=0;
int get currentIndex=>_currentIndex;
/*changeIndex start here*/
void changeIndex(int index){
  _currentIndex=index;
  notifyListeners();
}
/*changeIndex end here*/
/*pages start here*/
final List<Widget> pages=[
  HomeScreen(),
  Center(child: Text("Categories"),),
  BookMarksScreen(),
  ProfileScreen(),
];
/*pages end here*/
}