import 'package:dartz/dartz.dart';
import 'package:shop/core/error/failures.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/authentication/domain/entities/user.dart';
import 'package:shop/features/authentication/domain/repositories/auth_repository.dart';

class GetProfile implements UseCase<User, NoParams> {
  final AuthRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getUserProfile();
  }
  
  
}
