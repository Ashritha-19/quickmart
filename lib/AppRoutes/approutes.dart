import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quickmart/constants/bottomnavigationbar.dart';
import 'package:quickmart/slpash/splashscreen.dart';
import 'package:quickmart/views/login/createaccount.dart';
import 'package:quickmart/views/login/signin.dart';


class AppRoutes {
  static const splashscreen = '/splashscreen'; 
  static const signIn = '/signin';
  static const createAccount = '/create-account';
  static const sellerDashboard = '/seller-dashboard';
  static const sellerProducts = '/seller-products';
  static const uploadProduct = '/upload-product';
  static const sellerProfile = '/seller-profile';

  static final routes = [
    GetPage(name: splashscreen, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: createAccount, page: () => const CreateAccountScreen()),

    // 🔹 Wrap each seller screen with MainWrapper
    GetPage(
      name: sellerDashboard,
      page: () => const MainWrapper(initialIndex: 0),
    ),
    GetPage(
      name: sellerProducts,
      page: () => const MainWrapper(initialIndex: 1),
    ),
    GetPage(
      name: uploadProduct,
      page: () => const MainWrapper(initialIndex: 2),
    ),
    GetPage(
      name: sellerProfile,
      page: () => const MainWrapper(initialIndex: 3),
    ),
  ];
}
