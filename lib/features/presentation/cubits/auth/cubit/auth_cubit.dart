// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_current_user_id_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/is_signed_in_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUsecase signOutUsecase;
  final IsSignedInUseCase isSignedInUseCase;
  final GetCurrentUserIdUsecase getCurrentUserIdUsecase;
  AuthCubit({
    required this.signOutUsecase,
    required this.isSignedInUseCase,
    required this.getCurrentUserIdUsecase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignedIn = await isSignedInUseCase.call();
      if (isSignedIn == true) {
        final uid = await getCurrentUserIdUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUserIdUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
