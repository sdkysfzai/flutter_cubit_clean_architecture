import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miload/consts.dart';

import '../../../cubits/auth/cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: GestureDetector(
            onTap: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  PageConsts.signInPage, (route) => false);
            },
            child: const Text('Sign Out')),
      ),
    );
  }
}
