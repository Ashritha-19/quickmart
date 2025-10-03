// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickmart/AppRoutes/approutes.dart';
import 'package:quickmart/constants/colorconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Save account details locally
  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("fullName", _fullNameController.text);
      await prefs.setString("email", _emailController.text);
      await prefs.setString("password", _passwordController.text);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Account created successfully")),
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "Account created successfully!",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: ColorConstants.darkBlue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

     Get.toNamed(AppRoutes.sellerDashboard);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "← Back to Home",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: ColorConstants.darkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Center(
                    child: Text(
                      "Join QuickMart",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.darkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // // Buyer / Seller toggle
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: ColorConstants.lightGray.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: ColorConstants.blueShade,
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //           padding: const EdgeInsets.symmetric(vertical: 12),
                  //           child: Center(
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const Icon(
                  //                   Icons.shopping_bag,
                  //                   color: ColorConstants.white,
                  //                 ),
                  //                 const SizedBox(width: 5),
                  //                 Text(
                  //                   "Buyer",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w600,
                  //                     color: ColorConstants.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           padding: const EdgeInsets.symmetric(vertical: 12),
                  //           child: Center(
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const Icon(
                  //                   Icons.store,
                  //                   color: ColorConstants.gray,
                  //                 ),
                  //                 const SizedBox(width: 5),
                  //                 Text(
                  //                   "Seller",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 16,
                  //                     color: ColorConstants.gray,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 30),

                  // Create account box
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.blackish,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Full Name
                        _buildInputField(
                          controller: _fullNameController,
                          label: "Full Name",
                          hint: "Enter your full name",
                          validator: (value) =>
                              value!.isEmpty ? "Enter your name" : null,
                        ),
                        const SizedBox(height: 16),

                        // Email
                        _buildInputField(
                          controller: _emailController,
                          label: "Email",
                          hint: "Enter your email",
                          validator: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        _buildInputField(
                          controller: _passwordController,
                          label: "Password",
                          hint: "Create a password",
                          obscure: true,
                          validator: (value) =>
                              value!.length < 6 ? "Min 6 chars" : null,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password
                        _buildInputField(
                          controller: _confirmPasswordController,
                          label: "Confirm Password",
                          hint: "Confirm your password",
                          obscure: true,
                          validator: (value) =>
                              value!.isEmpty ? "Re-enter password" : null,
                        ),
                        const SizedBox(height: 20),

                        // Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.blueShade,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _saveAccount,
                            child: Text(
                              "Create Account",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.poppins(
                          color: ColorConstants.darkBlue,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in here",
                            style: GoogleFonts.poppins(
                              color: ColorConstants.blueShade,
                              fontWeight: FontWeight.w600,
                            ),
                             recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.signIn);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable input box
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorConstants.blackish,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: ColorConstants.blackish),
            filled: true,
            fillColor: ColorConstants.lightBlue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
