import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futsal_field_jepara_admin/utils/auth_guard.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart' as router_gr;
import 'package:hexcolor/hexcolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // Lock screen rotate
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Ada yang salah!!'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return buildMaterialApp();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Futsal Field Jepara Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Hexcolor('#EF4136'),
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      builder: ExtendedNavigator<router_gr.Router>(
        router: router_gr.Router(),
        guards: [AuthGuard()],
      ),
    );
  }
}
