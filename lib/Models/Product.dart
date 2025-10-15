class Product {
  final int id;
  final String name;
  final double price;
  final Productstatus status;
  final int stock;
  final int minimumStock;
  final String categoryName;
  final String imageUrl;

  Product(this.id, this.name, this.price, this.status, this.stock,
      this.minimumStock, this.categoryName, this.imageUrl);
  factory Product.fromJson(Map<String, dynamic> json) {
    String status = json['status'];
    Productstatus s;
    switch (status) {
      case 'InStock':
        s = Productstatus.InStock;
      case 'LowStock':
        s = Productstatus.LowStock;
      case 'OutOfStock':
        s = Productstatus.OutOfStock;
      case 'NoStockable':
        s = Productstatus.NoStockable;
      default:
        throw Exception('Unknown ProductStatus: $status');
    }
    return Product(json['id'], json['name'], json['price'], s, json['stock'],
        json['minimumStock'], json["categoryName"], json["imageUrl"]);
  }
}

enum Productstatus { InStock, LowStock, OutOfStock, NoStockable }
