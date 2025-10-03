// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickmart/constants/colorconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _pointsController = TextEditingController();
  final _stockController = TextEditingController();
  String? _selectedCategory;
  final List<File> _images = [];

  // Pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 60);

    if (picked != null) {
      setState(() {
        _images.add(File(picked.path));
      });
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveProduct() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert images to base64
    List<String> base64Images = _images
        .map((img) => base64Encode(img.readAsBytesSync()))
        .toList();

    Map<String, dynamic> product = {
      "name": _nameController.text,
      "description": _descController.text,
      "price": _priceController.text,
      "points": _pointsController.text,
      "stock": _stockController.text,
      "category": _selectedCategory ?? "",
      "images": base64Images,
    };

    // Get existing list
    List<String> products = prefs.getStringList("products") ?? [];
    products.add(jsonEncode(product));

    await prefs.setStringList("products", products);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Product saved locally!")));

    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _descController.clear();
    _priceController.clear();
    _pointsController.clear();
    _stockController.clear();
    _selectedCategory = null;
    _images.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: ColorConstants.blueShade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Upload Product",
                        style: GoogleFonts.poppins(
                          color: ColorConstants.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Add a new product to your store",
                        style: GoogleFonts.poppins(
                          color: ColorConstants.lightGray,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload Images
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorConstants.grey),
                        ),
                        child: Column(
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ..._images.map(
                                  (img) => Image.file(
                                    img,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showImageSourceDialog();
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.lightBlue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Card(
                        //  elevation: 4,
                        color: ColorConstants.white.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Details",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.darkBlue,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildTextField("Product Name", _nameController),
                              const SizedBox(height: 12),
                              _buildTextField(
                                "Description",
                                _descController,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      "Price (₹)",
                                      _priceController,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildTextField(
                                      "Reward Points",
                                      _pointsController,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(child: _buildDropdownField()),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    // <-- Fix here
                                    child: _buildTextField(
                                      "Stock",
                                      _stockController,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.blueShade,
                            foregroundColor: ColorConstants.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          icon: const Icon(Icons.upload),
                          label: Text(
                            "Save Product",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          onPressed: _saveProduct,
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
    );
  }

  // Show camera/gallery picker
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Custom TextField
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: ColorConstants.darkBlue,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(color: ColorConstants.blackish),
          decoration: InputDecoration(
            hintText: "Enter $label",
            hintStyle: GoogleFonts.poppins(color: ColorConstants.gray),
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

  // Dropdown
  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: ColorConstants.darkBlue,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: ColorConstants.lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(border: InputBorder.none),
            value: _selectedCategory,
            items: ["Electronics", "Clothing", "Books"]
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            style: GoogleFonts.poppins(color: ColorConstants.blackish),
          ),
        ),
      ],
    );
  }
}
