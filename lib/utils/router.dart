import 'package:auto_route/auto_route_annotations.dart';
import 'package:futsal_field_jepara_admin/screens/complete_user_profile_data_screen.dart';
import 'package:futsal_field_jepara_admin/screens/home_screen.dart';
import 'package:futsal_field_jepara_admin/screens/sign_in_screen.dart';
import 'package:futsal_field_jepara_admin/screens/user_profile_screen.dart';
import 'package:futsal_field_jepara_admin/utils/auth_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(
      page: HomeScreen,
      guards: [AuthGuard],
      initial: true,
    ),
    AdaptiveRoute(
      page: SignInScreen,
    ),
    AdaptiveRoute(
      page: CompleteUserProfileDataScreen,
      guards: [AuthGuard],
    ),
    AdaptiveRoute(
      page: UserProfileScreen,
      guards: [AuthGuard],
    ),
  ],
)
class $Router {}
