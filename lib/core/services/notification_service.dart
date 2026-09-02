import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_wave/core/navigation/navigation_service.dart';
import 'package:news_wave/features/home/webview_screen.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';

class NotificationService{
  NotificationService._();
  /*instance start here*/
static final FirebaseMessaging _messaging=FirebaseMessaging.instance;
static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();
/*instance end here*/
static RemoteMessage? initialMessage;
/*init start here*/
static Future<void> init() async{
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('news_logo');
  const DarwinInitializationSettings iosSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  _flutterLocalNotificationsPlugin.initialize(settings,
    onDidReceiveNotificationResponse: (response) {
if(response.payload != null && response.payload!.isNotEmpty){
_navigateToWebView(response.payload!);
}
},);
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'newswave_channel',
    'NewsWave Notifications',
    description: 'NewsWave breaking news notifications',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );
  // ✅ Create notification channel (Android 8.0+)
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation
  <AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // ✅ Request notification permission (Android 13+)
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
/*init end here*/
/*requestPermission start here*/
static Future<void> requestPermission()async{
  final NotificationSettings settings=await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );
  if (kDebugMode) {
    debugPrint('🔑 Permission: ${settings.authorizationStatus}');
  }
}
/*requestPermission end here*/

  /*getDeviceToken start here*/
  static Future<String?> getDeviceToken() async {
    final String? token = await _messaging.getToken();
    if (kDebugMode) {
      debugPrint('📱 FCM Token: $token');
    }
    return token;
  }
/*getDeviceToken end here*/
  /*isTokenRefresh start here*/
  static void isTokenRefresh() {
    _messaging.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        debugPrint('🔄 New Token: $newToken');
      }
    });
  }
/*isTokenRefresh end here*/
/*firebaseInit start here*/
static void firebaseInit(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      debugPrint('🔔 Foreground Notification!');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Data: ${message.data}');
    }
    if (Platform.isAndroid) {
      showNotification(message);
    }
  });
}
/*firebaseInit end here*/
/*showNotification start here*/
static Future<void> showNotification(RemoteMessage message) async{
String? url= message.data["url"];
final AndroidNotificationDetails androidDetails =
AndroidNotificationDetails(
  'newswave_channel',
  'NewsWave Notifications',
  channelDescription: 'NewsWave breaking news notifications',
  importance: Importance.max,
  priority: Priority.max,
  playSound: true,
  enableVibration: true,
  icon: '@drawable/news_logo',
  styleInformation: BigTextStyleInformation(
    message.notification?.body ?? '',
    contentTitle: message.notification?.title ?? 'NewsWave',
    htmlFormatBigText: true,
    htmlFormatContentTitle: true,
  ),
);
const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true,);

final NotificationDetails details = NotificationDetails(
  android: androidDetails,
  iOS: iosDetails,
);
await _flutterLocalNotificationsPlugin.show(
  message.hashCode,
  message.notification?.title ?? 'NewsWave',
  message.notification?.body ?? '',
  details,
  payload: url, // ✅ pass URL as payload
);
}
/*showNotification end here*/
/*listenBackgroundTap start here*/
static void listenBackgroundTap() {
  // ✅ background state
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (kDebugMode) {
      debugPrint('🔔 Notification Tapped (Background)');
      debugPrint('Data: ${message.data}');
    }
    handleMessage(message);
  });
}
/*listenBackgroundTap end here*/
/*handleMessage start here*/
static void handleMessage(RemoteMessage message){
  String? url= message.data["url"];
  String? title= message.data["title"];
  if(url==null || url.isEmpty) return;
  final navigationState=NavigationService.navigatorKey.currentState;
  if(navigationState==null){
    if(kDebugMode){
      debugPrint('❌ Navigator not ready — retrying...');
    }
    Future.delayed( const Duration(seconds: 1),(){
handleMessage(message);
    });
    return;
  }
  // ✅ navigate to WebViewScreen
  _navigateToWebView(url,title: title);
}
/*handleMessage end here*/
/*_navigateToWebView start here*/
static void _navigateToWebView(String url,{String? title}){
NavigationService.navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) =>
    WebViewScreen(articles: Articles(
      url: url,
      title: title,
      source: Source(name: title??"NewsWave"),
    ),),),);
}
/*_navigateToWebView end here*/
}