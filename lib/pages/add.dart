import 'package:firebase_app_pbm/services/user_service.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerNIM = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("Nama"),
          TextField(
            controller: _controllerNama,
          ),
          const Text("NIM"),
          TextField(
            controller: _controllerNIM,
          ),
          ElevatedButton(
            onPressed: () {
              UserService.insert(
                nama: _controllerNama.text,
                nim: _controllerNIM.text,
              ).then(
                (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User berhasil ditambahkan"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
              );
            },
            child: const Text("Tambah"),
          ),
        ],
      ),
    );
  }
}
