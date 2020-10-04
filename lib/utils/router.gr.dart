// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/complete_user_profile_data_screen.dart';
import '../screens/home_screen.dart';
import '../screens/sign_in_screen.dart';
import 'auth_guard.dart';

class Routes {
  static const String homeScreen = '/';
  static const String signInScreen = '/sign-in-screen';
  static const String completeUserProfileDataScreen =
      '/complete-user-profile-data-screen';
  static const all = <String>{
    homeScreen,
    signInScreen,
    completeUserProfileDataScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen, guards: [AuthGuard]),
    RouteDef(Routes.signInScreen, page: SignInScreen),
    RouteDef(Routes.completeUserProfileDataScreen,
        page: CompleteUserProfileDataScreen, guards: [AuthGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    SignInScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInScreen(),
        settings: data,
      );
    },
    CompleteUserProfileDataScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CompleteUserProfileDataScreen(),
        settings: data,
      );
    },
  };
}
