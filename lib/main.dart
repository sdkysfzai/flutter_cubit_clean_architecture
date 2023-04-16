import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miload/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/user/cubit/single_user_cubit/cubit/get_single_user_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/user/cubit/user_cubit.dart';
import 'package:flutter_miload/features/presentation/pages/credentials/sign_in_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/main_screen.dart';
import 'package:flutter_miload/firebase_options.dart';
import 'package:flutter_miload/on_generate_route.dart';
import 'package:flutter_miload/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
      ],
      child: MaterialApp(
        title: 'MiLoad',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) => BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(
                      uid: authState.uid,
                    );
                  } else {
                    return const SignInPage();
                  }
                },
              ),
        },
      ),
    );
  }
}
