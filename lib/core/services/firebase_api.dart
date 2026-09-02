import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
/*firebaseMessagingBackgroundHandler start here*/
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  // ✅ init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ✅ init Firebase
  if(kDebugMode){
    debugPrint('🔔 Background Notification Received!');
    debugPrint('Title: ${message.notification?.title ?? "No title"}');
    debugPrint('Body: ${message.notification?.body ?? "No body"}');
    debugPrint('URL: ${message.data['url']}');
  }
}
/*firebaseMessagingBackgroundHandler end here*/
class FirebaseApi{
  /*initNotifications start here*/
  static Future<void> initNotifications()async{
    // ✅ Step 1 — background handler FIRST
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // ✅ Step 2 — request permission
    await NotificationService.requestPermission();
    // ✅ Step 3 — foreground options for iOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //✅ Step 4 — get device token
    await NotificationService.getDeviceToken();

    // ✅ Step 5 — token refresh
    NotificationService.isTokenRefresh();

    // ✅ Step 6 — foreground handler
    NotificationService.firebaseInit();
    // ✅ Step 7 — read initialMessage ONCE
    NotificationService.initialMessage= await FirebaseMessaging.instance.getInitialMessage();
if(kDebugMode) {
  debugPrint('📨 Initial Message: ${NotificationService.initialMessage?.data}',);
}
// ✅ Step 8 — background tap handler
  NotificationService.listenBackgroundTap();
    }
  /*initNotifications end here*/
}