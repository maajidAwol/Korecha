import 'package:dartz/dartz.dart';
import 'package:shop/features/product/domain/entities/category.dart';
import '../entities/product.dart';
import '../../../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String productId);
  Future<Either<Failure, List<Category>>> getProductCategories();
  Future<Either<Failure, List<Product>>> getProductsByCategoryId(String categoryId);
  
}

