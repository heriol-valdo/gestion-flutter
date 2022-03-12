

import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/gestion/Database_service/Database_user.dart';
import 'package:flutter_firebase/gestion/Model/AppUserId.dart';

import 'package:flutter_firebase/gestion/loading_circular/loading.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../bazard/models/user.dart';
import '../../bazard/Database_services/database.dart';
import '../../bazard/Database_services/notification_service.dart';

 class AuthenticationService{

   final FirebaseAuth _auth = FirebaseAuth.instance;


  AppUserId? _userFromFirebaseUser(User? user) {
    initUser(user);
    return user != null ? AppUserId(user.uid) : null;
  }

  void initUser(User? user) async {
    if (user == null) return;
    NotificationService.getToken().then((value) {
   //   DatabaseService(user.uid).saveToken(value);
    });
  }

  Stream<AppUserId?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      // ignore: deprecated_member_use
      return null;
    }
  }



  Future registerWithEmailAndPassword(String name,String age, String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {

        await DatabaseUser(user.uid).saveUser(name,email,"","","","","","","");
        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


 }






