class CartItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String coverUrl;
  final int quantity;
  final String? size;
  final String? color;
  final String address;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.coverUrl,
    required this.quantity,
    this.size,
    this.color,
    required this.address,
      });

  double get total => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    String? coverUrl,
    int? quantity,
    String? size,
    String? color,
    String? address,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      coverUrl: coverUrl ?? this.coverUrl,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      address: address ?? this.address,
    );
  }
}
