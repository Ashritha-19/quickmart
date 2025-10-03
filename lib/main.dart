import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmart/AppRoutes/approutes.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MarketPlace App",
    //   home: const SellerProfileScreen(), 
     initialRoute: AppRoutes.splashscreen,
     getPages: AppRoutes.routes,
    );
  }
}
