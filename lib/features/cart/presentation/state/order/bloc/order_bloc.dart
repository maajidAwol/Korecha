import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/features/cart/data/models/chapa_order_request_model.dart';
import 'package:shop/features/cart/data/models/cod_order_request_model.dart';
import 'package:shop/features/cart/domain/usecases/create_chapa_order.dart';
import 'package:shop/features/cart/domain/usecases/create_cod_order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateChapaOrderUseCase createChapaOrderUseCase;
  final CreateCodOrderUseCase createCashOnDeliveryOrderUseCase;
  OrderBloc({
    required this.createChapaOrderUseCase,
    required this.createCashOnDeliveryOrderUseCase,
  }) : super(OrderInitial()) {
    on<CreateChapaOrder>(_onCreateChapaOrder);
    on<CreateCashOnDeliveryOrder>(_onCreateCashOnDeliveryOrder);
  }

  Future<void> _onCreateChapaOrder(
      CreateChapaOrder event, Emitter<OrderState> emit) async {
    // TODO: implement _onCreateChapaOrder
    final order = event.order;
    final result = await createChapaOrderUseCase(order);
    result.fold(
      (failure) => emit(OrderFailure(failure.toString())),
      (success) => emit(ChapaOrderCreated()),
    );
  }

  Future<void> _onCreateCashOnDeliveryOrder(
      CreateCashOnDeliveryOrder event, Emitter<OrderState> emit) async {
    final order = event.order;
    final result = await createCashOnDeliveryOrderUseCase(order);
    result.fold(
      (failure) => emit(OrderFailure(failure.toString())),
      (success) => emit(CashOnDeliveryOrderCreated()),
    );
  }
}
