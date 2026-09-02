import 'package:flutter/cupertino.dart';
import 'package:news_wave/core/routes/route_names.dart';

class OnboardingProvider with ChangeNotifier{
final PageController pageController = PageController();
int _currentPage=0;
int get currentPage=>_currentPage;
final int totalPages=3;
/*onPageChange start here*/
void onPageChange(int index){
_currentPage=index;
notifyListeners();
}
/*onPageChange end here*/
  /*nextPage start here*/
  void nextPage(BuildContext context){
    if(_currentPage<totalPages-1){
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    else{
      Navigator.pushReplacementNamed(context, RouteNames.main);
    }
  }
  /*nextPage end here*/
  /*previousPage start here*/
  void previousPage(){
    if(_currentPage>0){
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
  /*previousPage end here*/
  /*skipToLastPage start here*/
  void skipToLastPage(){
    pageController.animateToPage(totalPages-1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  /*skipToLastPage end here*/
@override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}