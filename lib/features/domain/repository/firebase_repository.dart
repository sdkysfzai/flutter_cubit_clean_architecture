import 'package:flutter_miload/features/domain/entities/user/user.dart';

abstract class FirebaseRepository {

  //Credentials
  Future<void> signIn(UserEnitity user);
  Future<void> signUp(UserEnitity user);
  Future<bool> isSignedIn();
  Future<void> signOut();

  //User
  Future<void> createUser(UserEnitity user);
  Future<void> updateUser(UserEnitity user);
  Future<void> deleteUser(UserEnitity user);
  Future<String> getCurrentUserId();
  Future<UserEnitity> getUser(String uid);
  Future<List<UserEnitity>> getAllUsers(UserEnitity user);
}