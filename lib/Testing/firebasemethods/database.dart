import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseauth/Testing/firebasemethods/userchecklist.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference hostels = FirebaseFirestore.instance.collection('Hostel');

  UserCheckList _userFromCheckList(DocumentSnapshot snapshot) {
    Map<String, dynamic> myHostel = snapshot.data() as Map<String, dynamic>;

    //print(doc.data);
    return UserCheckList(
        userCheckedFire: List.from(myHostel['userCheckedFire']) ?? []);
  }

  Stream<UserCheckList?> get getCheckbox {
    return hostels
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map(_userFromCheckList);
  }

  Future addCheckbox(List UploadList) {
    return hostels
        .doc(_auth.currentUser!.uid)
        .update({
          'userCheckedFire': ["Hot Water"], // John Doe
        })
        .then((value) => print("Hostel User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
