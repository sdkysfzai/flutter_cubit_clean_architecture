import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_miload/features/data/data_sources/remote_date_source/remote_data_source.dart';
import 'package:flutter_miload/features/data/data_sources/remote_date_source/remote_data_source_impl.dart';
import 'package:flutter_miload/features/data/repository/firebase_repository_impl.dart';
import 'package:flutter_miload/features/domain/repository/firebase_repository.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_all_users_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_current_user_id_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/get_user_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/is_signed_in_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_in_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/sign_up_usecase.dart';
import 'package:flutter_miload/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:flutter_miload/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/user/cubit/single_user_cubit/cubit/get_single_user_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/user/cubit/user_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubits
 sl.registerFactory(
    () => AuthCubit(
      signOutUsecase: sl.call(),
      isSignedInUseCase: sl.call(),
      getCurrentUserIdUsecase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => CredentialCubit(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => UserCubit(
      getAllUsersUsecase: sl.call(),
      updateUserUsecase: sl.call(),
    ),
  );
  sl.registerFactory(() => GetSingleUserCubit(
      getUserUsecase: sl.call()));

  //usecases
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignedInUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => GetCurrentUserIdUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl.call()));


  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //Remote data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firestore: sl.call(), firebaseAuth: sl.call()));

  //externals
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
