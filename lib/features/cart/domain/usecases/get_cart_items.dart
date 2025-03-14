import 'package:dartz/dartz.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/cart/domain/entities/cart_item.dart';
import 'package:shop/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;

  GetCartItemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CartItem>>> call(void params) async {
    return await repository.getCartItems();
  }
}
