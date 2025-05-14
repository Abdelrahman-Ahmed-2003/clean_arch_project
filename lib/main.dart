import 'package:clean_arch_project/features/auth/data/data_sources/firebase_auth.dart';
import 'package:clean_arch_project/features/auth/data/repo_Impelementation/auth_resp_impl.dart';
import 'package:clean_arch_project/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_project/features/auth/domain/use_cases/login_with_user_use_case.dart';
import 'package:clean_arch_project/features/auth/presentation/bloc/login_bloc/auth_cubit.dart';
import 'package:clean_arch_project/features/auth/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final firebaseAuth = FirebaseAuth.instance;
  final dataSource = FirebaseAuthDataSource(auth: firebaseAuth);
  final authRepo = AuthRepositoryImpl(dataSource);
  final loginUseCase = LoginUseCase(authRepo);
  final loginWithGoogleUseCase = LoginWithGoogleUseCase(authRepo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(loginUseCase, loginWithGoogleUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

