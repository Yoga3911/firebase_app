import 'package:firebase_app_pbm/services/user_service.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String userId;
  final String nama;
  final String nim;
  const EditPage({
    super.key,
    required this.userId,
    required this.nama,
    required this.nim,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controllerNama;
  late TextEditingController _controllerNIM;

  @override
  void initState() {
    _controllerNama = TextEditingController(
      text: widget.nama,
    );
    _controllerNIM = TextEditingController(
      text: widget.nim,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
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
              UserService.update(
                userId: widget.userId,
                nama: _controllerNama.text,
                nim: _controllerNIM.text,
              ).then(
                (_) => Navigator.pop(context),
              );
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
