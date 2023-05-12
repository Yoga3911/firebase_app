import 'package:firebase_app_pbm/pages/home.dart';
import 'package:firebase_app_pbm/services/google_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Firebase App",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                GoogleAuth().signInWithGoogle().then((value) {
                  if (value.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          email: value.user?.email ?? "Null",
                        ),
                      ),
                    );
                  }
                });
              },
              child: const Text("Login with Google"),
            )
          ],
        ),
      ),
    );
  }
}
