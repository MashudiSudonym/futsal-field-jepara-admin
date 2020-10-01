import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';

class AuthGuard extends RouteGuard {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    final user = _auth.currentUser;
    print(user);

    if (user != null) {
      return true;
    }

    navigator.pushAndRemoveUntil(Routes.signInScreen, (route) => false);
    return false;
  }
}
