import 'package:dartz/dartz.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/cart/data/models/cod_order_request_model.dart';
import 'package:shop/features/cart/domain/entities/cart_item.dart';
import 'package:shop/features/cart/domain/entities/delivery_method.dart';
import 'package:shop/features/cart/domain/entities/payment_method.dart';
import 'package:shop/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop/features/cart/domain/repositories/order_repository.dart';

class CreateCodOrderUseCase implements UseCase<void, CashOnDeliveryOrder> {
  final OrderRepository repository;

  CreateCodOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CashOnDeliveryOrder order) async {
    return await repository.createCashOnDeliveryOrder(
      order: order,

    );
  }
}

