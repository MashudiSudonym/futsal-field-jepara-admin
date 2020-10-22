// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../screens/add_new_field_screen.dart';
import '../screens/complete_user_profile_data_screen.dart';
import '../screens/edit_user_profile_screen.dart';
import '../screens/field_detail_information_screen.dart';
import '../screens/field_information_screen.dart';
import '../screens/home_screen.dart';
import '../screens/order_detail_screen.dart';
import '../screens/order_screen.dart';
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
  static const String fieldInformationScreen = '/field-information-screen';
  static const String orderScreen = '/order-screen';
  static const String addNewFieldScreen = '/add-new-field-screen';
  static const String fieldDetailInformationScreen =
      '/field-detail-information-screen';
  static const String orderDetailScreen = '/order-detail-screen';
  static const all = <String>{
    homeScreen,
    signInScreen,
    completeUserProfileDataScreen,
    userProfileScreen,
    editUserProfileScreen,
    fieldInformationScreen,
    orderScreen,
    addNewFieldScreen,
    fieldDetailInformationScreen,
    orderDetailScreen,
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
    RouteDef(Routes.fieldInformationScreen,
        page: FieldInformationScreen, guards: [AuthGuard]),
    RouteDef(Routes.orderScreen, page: OrderScreen, guards: [AuthGuard]),
    RouteDef(Routes.addNewFieldScreen,
        page: AddNewFieldScreen, guards: [AuthGuard]),
    RouteDef(Routes.fieldDetailInformationScreen,
        page: FieldDetailInformationScreen, guards: [AuthGuard]),
    RouteDef(Routes.orderDetailScreen,
        page: OrderDetailScreen, guards: [AuthGuard]),
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
    FieldInformationScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FieldInformationScreen(),
        settings: data,
      );
    },
    OrderScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderScreen(),
        settings: data,
      );
    },
    AddNewFieldScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AddNewFieldScreen(),
        settings: data,
      );
    },
    FieldDetailInformationScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FieldDetailInformationScreen(),
        settings: data,
      );
    },
    OrderDetailScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderDetailScreen(),
        settings: data,
      );
    },
  };
}
