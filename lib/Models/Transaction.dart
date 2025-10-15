class Transaction {
  final int id;
  final String name;
  final double price;

  final int stock;
  final int minimumStock;
  final String categoryName;

  Transaction(this.id, this.name, this.price, this.stock, this.minimumStock,
      this.categoryName);
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(json['id'], json['name'], json['price'], json['stock'],
        json['minimumStock'], json["categoryName"]);
  }
}
