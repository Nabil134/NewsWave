import 'package:flutter/material.dart';
import 'package:news_wave/core/navigation/navigation_service.dart';
import 'package:news_wave/core/services/notification_service.dart';
import 'package:news_wave/features/home/webview_screen.dart';
import 'package:news_wave/features/main/presentations/main_screen.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';
import 'package:news_wave/features/onboarding/presentation/onboarding_screen.dart';

class SplashProvider with ChangeNotifier{

  /*navigateToOnboarding start here*/
  Future<void> navigateToOnboarding(BuildContext context) async {
  await  Future.delayed(const Duration(seconds: 3),);
    if(!context.mounted) return;
final message = NotificationService.initialMessage;
if(message!=null){
final String? title= message.data["title"];
final String? url= message.data["url"];
final String? source = message.data['source'];
if(url !=null && url.isNotEmpty){
  final articles=Articles(
    url: url,
    title: title,
    source: Source(name: source??"NewsWave"),
  );

  NotificationService.initialMessage=null;
  final navigator=NavigationService.navigatorKey.currentState;
  if(navigator==null) return;
  navigator.pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen(),),);
  await Future.delayed(const Duration(milliseconds: 300));
  navigator.push( MaterialPageRoute(builder: (_) => WebViewScreen(articles: articles,),),);
  return;
}
        }
  if (!context.mounted) return;
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingScreen(),),);
  }
  /*navigateToOnboarding end here*/

}