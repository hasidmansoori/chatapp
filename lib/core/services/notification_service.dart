import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  NotificationService._();
  factory NotificationService() => _instance;

  void init() {
    FirebaseMessaging.onMessage.listen((msg) {
      print('Message: ${msg.notification?.title}');
    });
  }

  Future<void> sendMessage({required String targetToken, required String title, required String body}) async {
    // Call FCM REST API (must be done from server, placeholder below)
    print('Sending to $targetToken: $title / $body');
  }
}
