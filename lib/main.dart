import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futsal_field_jepara_admin/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Ada yang salah!!"),
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
          color: Colors.redAccent[400],
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Poppins",
      ),
      home: HomeScreen(),
    );
  }
}
