import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_user_usecase.dart';

part 'get_single_user_cubit_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserCubitState> {
  final GetUserUsecase getUserUsecase;
  GetSingleUserCubit({required this.getUserUsecase}) : super(GetSingleUserCubitInitial());

  Future<void> getUser({required String uid}) async {
    emit(GetSingleUserCubitLoading());

    try{
      final user = await getUserUsecase.call(uid);
      emit(GetSingleUserCubitLoaded(user: user));
    } on SocketException catch(_) {
      emit(GetSingleUserCubitFailure());
    } catch (_) {
      emit(GetSingleUserCubitFailure());

    }
  }
}
