import 'package:get/get.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/home/home_page.dart';
import '../views/map/map_page.dart';
import '../bindings/initial_bindings.dart';


class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), binding: InitialBindings()),
    GetPage(name: Routes.REGISTER, page: () => RegisterPage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.MAP, page: () => MapPage()),
  ];
}
abstract class Routes {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const MAP = '/map';
}