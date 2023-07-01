import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  Future<void> updataUserData(
      String fullName, String email, String Phone) async {
    await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
      "PhoneNumber": Phone,
    });
  }

  Future GettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  GetUserGroup() async {
    return await userCollection.doc(uid).snapshots();
  }
}
