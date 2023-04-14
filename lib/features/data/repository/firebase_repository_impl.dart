import 'package:flutter_miload/features/data/data_sources/remote_date_source/remote_data_source.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createUser(UserEnitity user) async => remoteDataSource.createUser(user);

  @override
  Future<void> deleteUser(UserEnitity user) async => remoteDataSource.deleteUser(user);

  @override
  Future<List<UserEnitity>> getAllUsers(UserEnitity user) => remoteDataSource.getAllUsers(user);

  @override
  Future<String> getCurrentUserId() async => remoteDataSource.getCurrentUserId();

  @override
  Future<UserEnitity> getUser(String uid) => remoteDataSource.getUser(uid);

  @override
  Future<bool> isSignedIn() async => remoteDataSource.isSignedIn();

  @override
  Future<void> signIn(UserEnitity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEnitity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateUser(UserEnitity user) async => remoteDataSource.updateUser(user);

}