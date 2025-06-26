import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/localization/translations.dart';
import 'routes/app_pages.dart';
import 'bindings/initial_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAhLmnXKTj3-Q7bbcWE369pFkTDmeoQ_C4",
        authDomain: "chat-app-42c7d.firebaseapp.com",
        projectId: "chat-app-42c7d",
        storageBucket: "chat-app-42c7d.firebasestorage.app",
        messagingSenderId: "560736625398",
        appId: "1:560736625398:web:2dc89d23d97f67454cc2d7",
        measurementId: "G-Z606P2KESX",
      ),
    );
  } else {
    // Mobile platforms initialize automatically from native config files
    await Firebase.initializeApp();
  }
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      initialRoute: Routes.LOGIN,
      getPages: AppPages.pages,
      translations: Messages(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      debugShowCheckedModeBanner: false,
    );
  }
}
