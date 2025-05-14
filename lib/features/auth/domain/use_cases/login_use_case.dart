import 'package:clean_arch_project/core/error/fail.dart';
import 'package:clean_arch_project/features/auth/domain/entities/user_entity.dart';
import 'package:clean_arch_project/features/auth/domain/repo_interface/auth_repo.dart';
import 'package:dartz/dartz.dart';


class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}