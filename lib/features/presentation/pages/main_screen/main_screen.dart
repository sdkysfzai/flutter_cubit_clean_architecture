// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/presentation/cubits/user/cubit/single_user_cubit/cubit/get_single_user_cubit.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/home/home_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/my_trips/my_trips_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/profile/profile_page.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/wallet/wallet_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({
    Key? key,
   required this.uid,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getUser(uid: widget.uid);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserCubitState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserCubitLoaded) {
            final user = singleUserState.user;
            return Scaffold(
              backgroundColor: bgColor,
              bottomNavigationBar: CupertinoTabBar(
                  activeColor: blackColor,
                  currentIndex: _currentIndex,
                  onTap: navigationTapped,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, color: primaryColor),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.edit_document, color: primaryColor),
                        label: 'My Trips'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, color: primaryColor),
                        label: 'Wallet'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, color: primaryColor),
                        label: 'Profile'),
                  ],
                  backgroundColor: bgColor),
              body: PageView(
                controller: _pageController,
                onPageChanged: onPageChanged,
                children:  [
                  HomePage(user: user),
                 const MyTripsPage(),
                 const WalletPage(),
                 const ProfilePage(),
                ],
              ),
            );
          }
          return const Scaffold(
            backgroundColor: bgColor,
            body:  Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
