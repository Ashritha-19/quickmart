// lib/views/seller_screens/seller_profile.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickmart/constants/colorconstants.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Content
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Header
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                const SizedBox(height: 12),
                Text(
                  "John Doe",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.darkBlue,
                  ),
                ),
                Text(
                  "john@example.com",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: ColorConstants.gray,
                  ),
                ),
                const SizedBox(height: 20),

                // Revenue card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorConstants.lightBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Revenue",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: ColorConstants.lightGray,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₹54,000",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Options
                _buildOption(Icons.store, "My Products"),
                _buildOption(Icons.payment, "Payments"),
                _buildOption(Icons.settings, "Settings"),
                _buildOption(Icons.logout, "Logout", isLogout: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(IconData icon, String label, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isLogout ? Colors.red : ColorConstants.blueShade),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isLogout ? Colors.red : ColorConstants.blackish,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
