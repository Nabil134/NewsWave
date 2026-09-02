import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/core/navigation/navigation_service.dart';
import 'package:news_wave/core/routes/app_routes.dart';
import 'package:news_wave/core/routes/route_names.dart';
import 'package:news_wave/core/services/firebase_api.dart';
import 'package:news_wave/core/services/notification_service.dart';
import 'package:news_wave/core/theme/app_theme.dart';
import 'package:news_wave/features/bookmarks/providers/bookmarks_provider.dart';
import 'package:news_wave/features/onboarding/providers/onboarding_provider.dart';
import 'package:news_wave/features/splash/providers/splash_provider.dart';
import 'package:news_wave/features/theme/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'features/home/providers/home_provider.dart';
import 'features/main/providers/main_provider.dart';
import 'features/news/providers/news_provider.dart';
import 'features/search/provider/search_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  await FirebaseApi.initNotifications();
  await dotenv.load(fileName:'.env');
  runApp(
    EasyLocalization(child:
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SplashProvider(),),
      ChangeNotifierProvider(create: (context) => OnboardingProvider(),),
      ChangeNotifierProvider(create: (context) => MainProvider(),),
      ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ChangeNotifierProvider(create: (context) => NewsProvider(),),
      ChangeNotifierProvider(create: (context) => ThemeProvider()..loadTheme(),),
      ChangeNotifierProvider(create: (context) => SearchProvider(),),
      ChangeNotifierProvider(create: (context) => BookmarksProvider(),),
    ],
      child:  MyApp(),
    ),
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('ar'),

      ], path: "assets/translations",
      fallbackLocale: const Locale("en"),
      startLocale: const Locale("en"),
      saveLocale: true,
      useOnlyLangCode: true,
    ),



  );
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider= context.watch<ThemeProvider>();
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName.tr(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

