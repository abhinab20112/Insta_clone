import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/model/user.dart' as model;
import 'package:instagram/resources/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _fireStore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String phoyoURL = await StorageMethods()
            .uploadImageToString("profilePic", file, false);
        model.User user = model.User(
          bio: bio,
          userName: username,
          uid: userCredential.user!.uid,
          email: email,
          photoUrl: phoyoURL,
          followers: [],
          following: [],
        );
        await _fireStore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = 'Success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = "the email is not formatted correctly";
      } else if (e.code == 'weak-password') {
        res = " please enter a strong password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
    Future<void> signOut() async {
    await _auth.signOut();
  }
}
