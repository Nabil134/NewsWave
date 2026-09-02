import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/routes/route_names.dart';
import 'package:news_wave/features/language/presentation/language_screen.dart';
import 'package:news_wave/features/main/presentations/main_screen.dart';
import 'package:news_wave/features/onboarding/presentation/onboarding_screen.dart';
import 'package:news_wave/features/search/presentation/search_screen.dart';
import 'package:news_wave/features/splash/presentation/splash_screen.dart';

class AppRoutes{
  AppRoutes._();
  /*generateRoute start here*/
static Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case RouteNames.splash:
      return MaterialPageRoute(builder: (context) => const SplashScreen(),);
    case RouteNames.onboarding:
      return MaterialPageRoute(builder: (context) => const OnboardingScreen(),);
    case RouteNames.main:
      return MaterialPageRoute(builder: (context) => const MainScreen(),);
    case RouteNames.search:
      return MaterialPageRoute(builder: (context) =>  SearchScreen(),);
    case RouteNames.changeLanguage:
      return MaterialPageRoute(builder: (context) => const LanguageScreen(),);
    default:
      return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: const Text("No Route Found"),),),);
  }
}
/*generateRoute end here*/
}