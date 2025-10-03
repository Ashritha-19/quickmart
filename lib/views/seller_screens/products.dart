// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickmart/constants/colorconstants.dart';
import 'package:quickmart/models/prodmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerProductScreen extends StatefulWidget {
  const SellerProductScreen({super.key});

  @override
  State<SellerProductScreen> createState() => _SellerProductScreenState();
}

class _SellerProductScreenState extends State<SellerProductScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productList = prefs.getStringList("products") ?? [];
    setState(() {
      _products = productList
          .map((e) => Product.fromJson(jsonDecode(e)))
          .toList();
    });
  }

  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productList = _products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList("products", productList);
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  color: ColorConstants.blueShade,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Products",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${_products.length} products listed",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: ColorConstants.lightGray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Product List
                Expanded(
                  child: _products.isEmpty
                      ? Center(
                          child: Text(
                            "No products added yet!",
                            style: GoogleFonts.poppins(
                              color: ColorConstants.gray,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            final p = _products[index];
                            return productCard(p);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(Product product) {
    Uint8List? imageBytes;
    if (product.images.isNotEmpty) {
      try {
        imageBytes = base64Decode(product.images[0]);
      } catch (e) {
        imageBytes = null;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
              const SizedBox(width: 12),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.blackish,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹${product.price}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.blueShade,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Row for Status + Stock
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.status == "active"
                                ? ColorConstants.blueShade
                                : ColorConstants.lightBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            product.status,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Stock: ${product.stock}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackish,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Row for Views + Sold
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.views.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorConstants.gray,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "${product.sold} sold",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorConstants.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: ColorConstants.gray),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) {
                  if (value == "toggle") {
                    setState(() {
                      product.status = product.status == "active"
                          ? "inactive"
                          : "active";
                    });
                    _saveProducts();
                  } else if (value == "remove") {
                    setState(() {
                      _products.remove(product);
                    });
                    _saveProducts();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "toggle",
                    child: Row(
                      children: [
                        Icon(
                          product.status == "active"
                              ? Icons.block
                              : Icons.check_circle,
                          color: Colors.blue,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.status == "active"
                              ? "Deactivate"
                              : "Activate",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "remove",
                    child: Row(
                      children: [
                        const Icon(Icons.delete, color: Colors.red, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Remove",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
