import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegeline_vendor/models/user.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String createVendorURL =
      "https://us-central1-vege-line.cloudfunctions.net/createVendor ";

  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser firebaseUser) =>
      firebaseUser == null ? null : User(firebaseUser.uid);

  Future<User> createUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(authResult.user);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<User> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(authResult.user);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Vendor> registerVendorWithEmailAndPassword(
      {String email, String password, Vendor vendor}) async {
    try {
      print('making request-------------------');
      var vendorJson = vendor.toJson();
      final response = await http.post(createVendorURL, body: {
        'email': email,
        'password': password,
        'vendor': jsonEncode(vendorJson)
      });
      print('created vendor-----------------');
      print(response.body);
      print(response.statusCode);
      vendorJson = jsonDecode(response.body);
      print('returning vendor----------------');
      return Vendor.fromJson(vendorJson);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> signOut() => _auth.signOut();

  Stream<User> get currentUserStream =>
      _auth.onAuthStateChanged.map(_userFromFirebaseUser);
}
