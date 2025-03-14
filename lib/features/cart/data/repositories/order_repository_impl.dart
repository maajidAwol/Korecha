import 'package:dartz/dartz.dart';
import 'package:shop/core/error/exceptions.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/core/network/network_info.dart';
import 'package:shop/features/authentication/domain/entities/address.dart';
import 'package:shop/features/cart/data/models/cod_order_request_model.dart';
import 'package:shop/features/cart/data/models/cod_order_response.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/chapa_order_request_model.dart';
import '../models/chapa_order_response_model.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/delivery_method.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CashOnDeliveryResponse>> createCashOnDeliveryOrder(
      {required CashOnDeliveryOrder order}) async {
    final result = await remoteDataSource.createCashOnDeliveryOrder(order);
    // TODO: implement createCashOnDeliveryOrder
    try {
      return right(result);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ChapaOrderResponse>> createChapaOrder(
      {required ChapaOrderModel order}) async {
    final result = await remoteDataSource.createChapaOrder(order);
    try {
      return right(result);
    } catch (e) {
      return left(ServerFailure());
    }
    // TODO: implement createChapaOrder
  }

  // @override
  // Future<Either<Failure, List<Order_Model>>> getUserOrders() async {
  //   // TODO: implement getUserOrders
  //   final result = await remoteDataSource.getUserOrders();
  //   try {
  //     return right(result.map((e) => Order_Model.fromJson(e)).toList());
  //   } catch (e) {
  //     return left(ServerFailure());
  //   }
  // }
}
