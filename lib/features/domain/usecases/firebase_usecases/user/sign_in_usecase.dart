import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository repository;

  SignInUsecase({required this.repository});

  Future<void> call(UserEnitity user){
    return repository.signIn(user);
  }
}