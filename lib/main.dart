import 'package:firebase_app_pbm/pages/home.dart';
import 'package:firebase_app_pbm/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final pref = await SharedPreferences.getInstance();
  final result = pref.getString("id");
  if (result == null) {
    return runApp(
      const MyApp(
        widget: LoginPage(),
      ),
    );
  } else {
    final email = pref.getString("email");
    return runApp(
      MyApp(
        widget: HomePage(email: email ?? ""),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget,
      debugShowCheckedModeBanner: false,
    );
  }
}
