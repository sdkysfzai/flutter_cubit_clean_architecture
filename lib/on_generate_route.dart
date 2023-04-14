import 'package:flutter/material.dart';
import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/presentation/pages/credentials/sign_in_page.dart';
import 'package:flutter_miload/features/presentation/pages/credentials/sign_up_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/home/home_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/main_screen.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/my_trips/my_trips_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/profile/profile_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/wallet/wallet_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      
      case PageConsts.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConsts.signUpPage:
      {
        return routeBuilder(const SignUpPage());
      }
      case PageConsts.mainScreen: {
        if(args is String) {

        return routeBuilder(  MainScreen(uid: args,));
        } else {
          return routeBuilder(const NoPageFound());
        }
      }
      case PageConsts.homePage: {
        if(args is UserEnitity) {

        return routeBuilder( HomePage(user: args,));
        } else {
          return routeBuilder(const NoPageFound());
        }
      }
      case PageConsts.myTripsPage: {
        return routeBuilder(const MyTripsPage());
      }
      case PageConsts.walletPage: {
        return routeBuilder(const WalletPage());
      }
      case PageConsts.profilePage: {
        return routeBuilder(const ProfilePage());
      }
      default:
        {
          return routeBuilder(const NoPageFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found!"),
      ),
      body: const Center(
        child: Text('Page not found!'),
      ),
    );
  }
}
