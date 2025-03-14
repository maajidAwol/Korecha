import 'package:dartz/dartz.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/cart/data/models/chapa_order_request_model.dart';
import 'package:shop/features/cart/domain/entities/cart_item.dart';
import 'package:shop/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop/features/cart/domain/repositories/order_repository.dart';

class CreateChapaOrderUseCase implements UseCase<void, ChapaOrderModel> {
  final OrderRepository repository;

  CreateChapaOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ChapaOrderModel order) async {
    return await repository.createChapaOrder(
      order: order,
    );
  }
}
