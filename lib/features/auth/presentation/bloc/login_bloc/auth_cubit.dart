import 'package:clean_arch_project/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_project/features/auth/domain/use_cases/login_with_user_use_case.dart';
import 'package:clean_arch_project/features/auth/presentation/bloc/login_bloc/auth._state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  AuthCubit(this.loginUseCase, this.loginWithGoogleUseCase)
      : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    final result = await loginUseCase(email, password);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());

    final result = await loginWithGoogleUseCase();

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
