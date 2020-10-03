import 'package:auto_route/auto_route.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    final user = data.auth.currentUser;
    print(user);

    if (user != null) {
      return true;
    }

    navigator.pushAndRemoveUntil(Routes.signInScreen, (route) => false);
    return false;
  }
}
