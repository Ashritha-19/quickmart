
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickmart/AppRoutes/approutes.dart';
import 'package:quickmart/constants/colorconstants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Foreground Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // Top Icon
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorConstants.blueShade,
                    child: const Icon(Icons.shopping_bag_outlined,
                        size: 40, color: ColorConstants.white),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Quick Mart",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Your gateway to seamless buying and selling. "
                    "Join thousands of users earning points with every purchase.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🔹 Buy Card
                  _buildCard(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: "I want to Buy",
                    subtitle:
                        "Explore amazing products and earn points with every purchase",
                    buttonText: "Browse Products",
                    buttonColor: ColorConstants.blueShade,
                    textColor: ColorConstants.white,
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Sell Card
                  _buildCard(
                    context,
                    icon: Icons.storefront_outlined,
                    title: "I want to Sell",
                    subtitle:
                        "Upload your products and start earning from your sales",
                    buttonText: "Start Selling",
                    buttonColor: ColorConstants.blueShade,
                    textColor: ColorConstants.white,
                  ),
                  const SizedBox(height: 20),

                  // Bottom Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                           Get.toNamed(AppRoutes.signIn);
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.blackish,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.createAccount);
                        },
                        child: Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.blackish,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable Card Builder
  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: buttonColor.withOpacity(0.1),
              child: Icon(icon, size: 30, color: buttonColor),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
