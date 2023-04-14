import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class GetAllUsersUsecase{
  final FirebaseRepository repository;

  GetAllUsersUsecase({ required this.repository});

  Future<List<UserEnitity>> call (UserEnitity user){
    return repository.getAllUsers(user);
  }
}