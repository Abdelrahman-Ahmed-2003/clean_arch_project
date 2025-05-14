import 'package:clean_arch_project/core/error/fail.dart';
import 'package:clean_arch_project/features/auth/domain/entities/user_entity.dart';
import 'package:clean_arch_project/features/auth/domain/repo_interface/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginWithGoogleUseCase {
  final AuthRepository repository;

  LoginWithGoogleUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.loginWithGoogle();
  }
}