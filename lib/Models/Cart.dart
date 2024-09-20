class Cart {
  final String uuid;
  final bool enabled;

  Cart(this.uuid, this.enabled);
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(json['uuid'], json['enabled']);
  }
}
