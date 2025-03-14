import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required String id,
    required String productId,
    required String name,
    required double price,
    required String coverUrl,
    required int quantity,
    String? size,
    String? color,
    String? address,
  }) : super(
          id: id,
          productId: productId,
          name: name, 
          price: price,
          coverUrl: coverUrl,
          quantity: quantity,
          size: size,
          color: color,
          address: address ?? '',
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      price: json['price'].toDouble(),
      coverUrl: json['coverUrl'],
      quantity: json['quantity'],
      size: json['size'],
      color: json['color'],
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'coverUrl': coverUrl,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}
