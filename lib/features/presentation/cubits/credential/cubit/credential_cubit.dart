// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';

import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_in_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  CredentialCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
  }) : super(CredentialInitial());

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());

    try {
      await signInUsecase.call(UserEnitity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (e) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEnitity user}) async {
    emit(CredentialLoading());

    try {
      await signUpUsecase.call(user);
      emit(CredentialSuccess());

    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

}
