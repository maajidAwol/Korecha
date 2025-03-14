import 'cart_item.dart';

class Order_Model {
  final String id;
  final String orderNumber;
  final double amount;
  final DateTime date;
  final String status;
  final List<CartItem> items;
  final String deliveryMethod;
  final String address;
  final String? invoiceNumber;
  final double? shippingFee;
  final double? tax;
  final double subtotal;
  final String paymentMethod;
  final String? txRef;

  Order_Model({
    required this.id,
    required this.orderNumber,
    required this.amount,
    required this.date,
    required this.status,
    required this.items,
    required this.deliveryMethod,
    required this.address,
    this.invoiceNumber,
    this.shippingFee,
    this.tax,
    required this.subtotal,
    required this.paymentMethod,
    this.txRef,
  });

  // Create from API response
  factory Order_Model.fromApiData({
    required String id,
    required String orderNumber,
    required double amount,
    required String status,
    required String createdAt,
    required String deliveryMethod,
    required String address,
    required List<CartItem> items,
    String? invoiceNumber,
    double? shippingFee,
    double? tax,
    required double subtotal,
    required String paymentMethod,
    String? txRef,
  }) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(createdAt);
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return Order_Model(
      id: id,
      orderNumber: orderNumber,
      amount: amount,
      date: parsedDate,
      status: status,
      items: items,
      deliveryMethod: deliveryMethod,
      address: address,
      invoiceNumber: invoiceNumber,
      shippingFee: shippingFee,
      tax: tax,
      subtotal: subtotal,
      paymentMethod: paymentMethod,
      txRef: txRef,
    );
  }
}
