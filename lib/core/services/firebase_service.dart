import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();
  FirebaseService._();
  factory FirebaseService() => _instance;

  Future<void> init() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();
}
