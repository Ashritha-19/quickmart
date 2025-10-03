class Product {
  String name;
  String description;
  String price;
  String points;
  String category;
  List<String> images; // base64 strings
  String status;       // active / inactive
  String stock;        // available stock
  String views;        // total views
  String sold;         // total sold

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.points,
    required this.category,
    required this.images,
    this.status = "active", // default when created
    this.stock = "0",
    this.views = "0",
    this.sold = "0",
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "points": points,
        "category": category,
        "images": images,
        "status": status,
        "stock": stock,
        "views": views,
        "sold": sold,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? "",
        points: json["points"] ?? "",
        category: json["category"] ?? "",
        images: List<String>.from(json["images"] ?? []),
        status: json["status"] ?? "active",
        stock: json["stock"] ?? "0",
        views: json["views"] ?? "0",
        sold: json["sold"] ?? "0",
      );
}
