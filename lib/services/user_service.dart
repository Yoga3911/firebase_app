import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();
  static CollectionReference users =
      FirebaseFirestore.instance.collection("users");
}

class UserService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MyCollection.users.get();
  }

  static Future insert({
    required String nama,
    required String nim,
  }) async {
    return await MyCollection.users.add({
      "nama": nama,
      "nim": nim,
    });
  }

  static Future update({
    required String userId,
    required String nama,
    required String nim,
  }) async {
    return await MyCollection.users.doc(userId).update({
      "nama": nama,
      "nim": nim,
    });
  }

  static Future delete({
    required String userId,
  }) async {
    return await MyCollection.users.doc(userId).delete();
  }
}
