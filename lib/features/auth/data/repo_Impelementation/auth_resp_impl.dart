import 'package:clean_arch_project/core/error/fail.dart';
import 'package:clean_arch_project/features/auth/data/data_sources/firebase_auth.dart';
import 'package:clean_arch_project/features/auth/domain/entities/user_entity.dart';
import 'package:clean_arch_project/features/auth/domain/repo_interface/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this.dataSource)
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final user = await dataSource.login(email, password);
      return Right(UserEntity(email: user.email ?? ""));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(Failure(message: "Google sign-in canceled"));
      }

      // Step 2: Get authentication credentials
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 3: Sign in with Firebase
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        return Right(UserEntity(email: user.email ?? ""));
      } else {
        return Left(Failure(message: "Failed to sign in with Google"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}