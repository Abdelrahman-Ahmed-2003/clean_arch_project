import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseUserModel {
  final String email;

  FirebaseUserModel({required this.email});

  factory FirebaseUserModel.fromFirebaseUser(User user) {
    return FirebaseUserModel(email: user.email ?? '');
  }

  UserEntity toEntity() {
    return UserEntity(email: email);
  }
}
