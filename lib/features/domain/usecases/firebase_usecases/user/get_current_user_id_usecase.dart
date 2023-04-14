import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class GetCurrentUserIdUsecase{
  final FirebaseRepository repository;
  GetCurrentUserIdUsecase({required this.repository});

  Future<String> call(){
    return repository.getCurrentUserId();
  }
}