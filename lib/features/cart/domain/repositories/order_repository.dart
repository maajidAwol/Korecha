import 'package:dartz/dartz.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/features/cart/data/models/cod_order_request_model.dart';
import 'package:shop/features/cart/data/models/cod_order_response.dart';
import '../../data/models/chapa_order_request_model.dart';
import '../../data/models/chapa_order_response_model.dart';
import '../entities/cart_item.dart';
import '../entities/delivery_method.dart';
import '../entities/order.dart';
import '../entities/payment_method.dart';

abstract class OrderRepository {
  /// Creates an order with Chapa payment method
  Future<Either<Failure, ChapaOrderResponse>> createChapaOrder({
    required ChapaOrderModel order,
  });

  /// Creates an order with Cash on Delivery payment method
  Future<Either<Failure, CashOnDeliveryResponse>> createCashOnDeliveryOrder({
    required CashOnDeliveryOrder order,
  });

  /// Gets all orders for the current user
  // Future<Either<Failure, List<Order_Model>>> getUserOrders();
}
