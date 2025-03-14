import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/repositories/product_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepository productRepository;

  CategoryBloc({required this.productRepository}) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await productRepository.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryProductsLoading());
    try {
      final products = await productRepository.getProductsByCategory(event.categoryId);
      emit(CategoryProductsLoaded(products));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
} 