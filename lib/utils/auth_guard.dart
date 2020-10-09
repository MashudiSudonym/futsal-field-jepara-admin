import 'package:auto_route/auto_route.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    final user = data.auth.currentUser;

    if (user != null) {
      return true;
    }

    await navigator.pushAndRemoveUntil(Routes.signInScreen, (route) => false);
    return false;
  }
}
