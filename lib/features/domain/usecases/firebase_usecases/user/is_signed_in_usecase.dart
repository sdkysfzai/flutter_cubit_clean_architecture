import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class IsSignedInUseCase {
  final FirebaseRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<bool> call(){
    return repository.isSignedIn();
  }
}