import 'dart:typed_data';
import '../models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async{
   String res="Some error occured";
   try{
    //signing up user
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file!=null){
      UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(cred.user!.uid);
      String photoUrl=await StorageMethods().uploadImageToStorage('profilePics', file, false);
      model.User user=model.User(
        uid: cred.user!.uid,
        email: email,
        username: username,
        bio: bio,
        photoUrl: photoUrl,
        followers: [],
        following: [],
        );
     await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      res="Success";
      }
   }
   catch(err){
     res=err.toString();
   }
   return res;
  }

   Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}