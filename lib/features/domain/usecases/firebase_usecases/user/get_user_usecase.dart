import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class GetUserUsecase {
  final FirebaseRepository repository;

  GetUserUsecase({required this.repository});

  Future<UserEnitity> call(String uid) {
    return repository.getUser(uid);
  }
}