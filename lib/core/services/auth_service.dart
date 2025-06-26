import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<User?> login(String email, String pass) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return cred.user;
  }

  static Future<User?> register(String email, String pass) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return cred.user;
  }

  static Future<void> logout() async => _auth.signOut();
  static User? get currentUser => _auth.currentUser;
}
