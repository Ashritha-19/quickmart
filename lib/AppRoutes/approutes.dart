

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quickmart/views/login/createaccount.dart';
import 'package:quickmart/views/login/signin.dart';
import 'package:quickmart/views/splashscreen.dart';


class AppRoutes {
  static const splashscreen = '/splashscreen'; 
  static const signIn = '/signin';
  static const createAccount = '/create-account';

  static final routes = [
    GetPage(name: splashscreen, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: createAccount, page: () => const CreateAccountScreen()),
  ];
}
