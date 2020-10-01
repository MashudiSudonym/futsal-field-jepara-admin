import 'package:auto_route/auto_route_annotations.dart';
import 'package:futsal_field_jepara_admin/screens/home_screen.dart';
import 'package:futsal_field_jepara_admin/screens/sign_in_screen.dart';
import 'package:futsal_field_jepara_admin/utils/auth_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(
      page: HomeScreen,
      guards: [AuthGuard],
      initial: true,
    ),
    MaterialRoute(
      page: SignInScreen,
    ),
  ],
)
class $Router {}
