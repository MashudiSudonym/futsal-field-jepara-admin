// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../screens/complete_user_profile_data_screen.dart';
import '../screens/edit_user_profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/user_profile_screen.dart';
import 'auth_guard.dart';

class Routes {
  static const String homeScreen = '/';
  static const String signInScreen = '/sign-in-screen';
  static const String completeUserProfileDataScreen =
      '/complete-user-profile-data-screen';
  static const String userProfileScreen = '/user-profile-screen';
  static const String editUserProfileScreen = '/edit-user-profile-screen';
  static const all = <String>{
    homeScreen,
    signInScreen,
    completeUserProfileDataScreen,
    userProfileScreen,
    editUserProfileScreen,
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
    RouteDef(Routes.userProfileScreen,
        page: UserProfileScreen, guards: [AuthGuard]),
    RouteDef(Routes.editUserProfileScreen,
        page: EditUserProfileScreen, guards: [AuthGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    SignInScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SignInScreen(),
        settings: data,
      );
    },
    CompleteUserProfileDataScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CompleteUserProfileDataScreen(),
        settings: data,
      );
    },
    UserProfileScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => UserProfileScreen(),
        settings: data,
      );
    },
    EditUserProfileScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => EditUserProfileScreen(),
        settings: data,
      );
    },
  };
}
