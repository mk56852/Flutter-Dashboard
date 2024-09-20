class Product {
  final int id;
  final String name;
  final double price;
  final Productstatus status;
  final int stock;
  final int minimumStock;
  final String categoryName;

  Product(this.id, this.name, this.price, this.status, this.stock,
      this.minimumStock, this.categoryName);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['name'], json['price'], json['status'],
        json['stock'], json['minimumStock'], json["categoryName"]);
  }
}

enum Productstatus { InStock, LowStock, OutOfStock, NoStockable }
