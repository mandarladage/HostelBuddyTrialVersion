import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseauth/models/hostel/hosteluserprofile.dart';
import 'package:firbaseauth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference hostels = FirebaseFirestore.instance.collection('Hostel');

  //create user obj based on User
  UserData? _userFromFirebaseUser(User? FirebaseUser) {
    return FirebaseUser != null ? UserData(uid: FirebaseUser.uid) : null;
  }

  //Create object for hostel profile from firebasedata
  HostelUserProfile _hostelProfileFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> myHostel = snapshot.data() as Map<String, dynamic>;
    //print(doc.data);
    return HostelUserProfile(
        firstname: myHostel['firstname'] ?? '',
        lastname: myHostel['lastname'] ?? '',
        contactnumber: myHostel['contactnumber'] ?? '',
        address: myHostel['address'] ?? '');
  }

  //Create stream for hosteluserprofile
  Stream<HostelUserProfile?> get hosteluserprofile {
    return hostels
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map(_hostelProfileFromSnapshot);
  }

  //Create a stream for User auth changes
  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in ano
  Future signInAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      var user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Add in in cloud firestore database
  Future addInDatabase(String username, String password) async {
    bool uploaded = false;
    User? result = _auth.currentUser;

    try {
      await hostels.doc(result!.uid).set({
        'username': username,
        'email': result?.email,
        'password': password,
      }).then((value) {
        uploaded = true;
        return uploaded;
      }).catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print(e.toString());
      return uploaded;
    }
  }

  Future retriveForLogin(String username, String password) async {
    QuerySnapshot result =
        await hostels.where('username', isEqualTo: username).get();
    if (result.docs.length == 0) {
      print('its empty');
    } else {
      var temp1 = result.docs[0].data() as Map<String, dynamic>;
      print(result.docs.length);
      print(temp1['email']);
      await signInWithEmailAndPassword(temp1['email'], password);
    }
  }

  //register email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
