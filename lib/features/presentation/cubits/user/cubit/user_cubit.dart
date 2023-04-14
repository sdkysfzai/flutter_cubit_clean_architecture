// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_all_users_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUsecase updateUserUsecase;
  final GetAllUsersUsecase getAllUsersUsecase;
  UserCubit({
    required this.updateUserUsecase,
    required this.getAllUsersUsecase,
  }) : super(UserInitial());

  Future<void> getUsers({required UserEnitity users}) async {
    emit(UserLoading());

    try {
      final futureResponse = await getAllUsersUsecase.call(users);
      emit(UserLoaded(user: futureResponse));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEnitity user}) async {
    try {
      await updateUserUsecase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
