import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmart/AppRoutes/approutes.dart';
import 'package:quickmart/constants/colorconstants.dart';
import 'package:quickmart/views/seller_screens/dashboard.dart';
import 'package:quickmart/views/seller_screens/products.dart';
import 'package:quickmart/views/seller_screens/seller_profile.dart';
import 'package:quickmart/views/seller_screens/uploadprod.dart';

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  const MainWrapper({super.key, this.initialIndex = 0}); // default 0

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // 👈 use initial index from routes
  }

  final List<Widget> _screens = const [
    SellerDashboardScreen(),
    SellerProductScreen(),
    UploadProductScreen(),
    SellerProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.sellerDashboard);
        break;
      case 1:
        Get.offAllNamed(AppRoutes.sellerProducts);
        break;
      case 2:
        Get.offAllNamed(AppRoutes.uploadProduct);
        break;
      case 3:
        Get.offAllNamed(AppRoutes.sellerProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.blueShade,
        unselectedItemColor: ColorConstants.gray,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Upload"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
