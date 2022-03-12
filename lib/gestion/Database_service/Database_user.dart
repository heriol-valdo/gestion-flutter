import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Model/AppUserGestion.dart';

class DatabaseUser {
  final String uid;

  DatabaseUser(this.uid);

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  FirebaseFirestore.instance.collection("utilisateurs");





  Future<void> saveUser(String name,String email,String telephone,String adresse,String religion,
      String etudes,String taille,String statut,String age) async {
    /* await userCollection.doc(uid).collection("etat_stock").doc(uid).set({'quantite': name});
     await userCollection.doc(uid).collection("bordereau").doc(uid).set({'quantite': name});*/
    await userCollection.doc(uid).set({'name': name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'photo':""});

  }
  AppUserGestion _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return AppUserGestion(
      uid: snapshot.id,
      name: data['name'],
    );
  }

  Stream<AppUserGestion> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserGestion>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserGestion>> get users {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    //return userCollection.snapshots().map(_userListFromSnapshot);
  }






}