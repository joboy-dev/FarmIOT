import 'package:firebase_messaging/firebase_messaging.dart';

class CloudMessaging {
  Future pushNotification() async {
    // Get FCM Token ie Firebase Cloud Messaging Token
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }
}
