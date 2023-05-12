import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_pbm/pages/add.dart';
import 'package:firebase_app_pbm/pages/edit.dart';
import 'package:firebase_app_pbm/pages/login.dart';
import 'package:firebase_app_pbm/services/google_auth.dart';
import 'package:firebase_app_pbm/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({
    super.key,
    required this.email,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.email,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoogleAuth().logout().then((_) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                    (route) => false);
              });
              SharedPreferences.getInstance().then((pref) {
                pref.remove("id");
              });
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddPage(),
          ),
        ).then((_) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: UserService.getAll(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data?.docs ?? [];

          return ListView(
            children: users
                .map(
                  (e) => ListTile(
                    title: Text(e["nama"]),
                    subtitle: Text(e["nim"]),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditPage(
                          userId: e.id,
                          nama: e["nama"],
                          nim: e["nim"],
                        ),
                      ),
                    ).then((_) {
                      setState(() {});
                    }),
                    trailing: IconButton(
                      onPressed: () {
                        UserService.delete(userId: e.id).then((_) {
                          setState(() {});
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
