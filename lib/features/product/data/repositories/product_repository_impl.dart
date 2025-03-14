import 'package:dartz/dartz.dart';
import 'package:shop/features/product/domain/entities/category.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    print('getProducts');
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts();
        
        return Right(products);
      } catch (e) {
        // print(e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      // print('getProducts else');
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(productId);
        return Right(product);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getProductCategories() async {
    if (await networkInfo.isConnected) {
      try {
            final categories = await remoteDataSource.getProductCategories();
        return Right(categories);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  @override
  Future<Either<Failure, List<Product>>> getProductsByCategoryId(String categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategoryId(categoryId);
        return Right(products); 
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
