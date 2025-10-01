// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickmart/constants/colorconstants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    String savedEmail = prefs.getString("email") ?? "";
    String savedPassword = prefs.getString("password") ?? "";

    setState(() {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
    });

    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      setState(() {
        emailController.text = args["email"] ?? emailController.text;
        passwordController.text = args["password"] ?? passwordController.text;
      });
    }
  }

  void _showCustomSnackbar(String title, String message, bool success) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: success ? ColorConstants.blackish : Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
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
                  // Back button
                  TextButton(
                    onPressed: () => Get.back(),
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
                      "Welcome Back",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.darkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Buyer / Seller toggle
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGray.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.blueShade,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.shopping_bag,
                                      color: ColorConstants.white),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Buyer",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.store,
                                      color: ColorConstants.gray),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Seller",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: ColorConstants.gray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign in box
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
                          "Sign in to Your Account",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.blackish,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email field
                        _buildInputField(
                          label: "Email",
                          hint: "Enter your email",
                          controller: emailController,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter email" : null,
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        _buildInputField(
                          label: "Password",
                          hint: "Enter your password",
                          controller: passwordController,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter password" : null,
                          obscure: true,
                        ),
                        const SizedBox(height: 20),

                        // Sign In button
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String savedEmail =
                                    prefs.getString("email") ?? "";
                                String savedPassword =
                                    prefs.getString("password") ?? "";

                                if (emailController.text == savedEmail &&
                                    passwordController.text == savedPassword) {
                                  _showCustomSnackbar("Success",
                                      "Sign in successful!", true);
                                  // Get.to(() => HomeScreen());
                                } else {
                                  _showCustomSnackbar("Error",
                                      "Invalid email or password!", false);
                                }
                              }
                            },
                            child: Text(
                              "Sign In",
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
                        text: "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          color: ColorConstants.darkBlue,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign up here",
                            style: GoogleFonts.poppins(
                              color: ColorConstants.blueShade,
                              fontWeight: FontWeight.w600,
                            ),
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

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
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
