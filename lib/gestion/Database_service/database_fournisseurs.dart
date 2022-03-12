import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/gestion/list_view/article_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/fournisseurs_model.dart';
import '../list_view/fournisseurs_list.dart';

class DatabaseFournisseurs{



  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  FirebaseFirestore.instance.collection("fournisseurs");


  // supprime l'utilisayeur de maniere async en local er base externe
  Future<void> deleteUser(String user) async {
    await userCollection.doc(user).delete();
  }



  Future<void> updateFournisseurs(BuildContext context,String user,String name,String numero,String ville) async {

    await userCollection.doc(user).update({'name': name,'numero':numero,'ville': ville});
     //Navigator.of(context).pop();
  }
  Fournisseurs _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return Fournisseurs(
      uid: snapshot.id,
      name: data['name'],
      numero: data['numero'],
      ville: data['ville'],
      codeFournisseurs: data['codeFournisseur']
    );
  }

  Stream<Fournisseurs> get user {
    return userCollection.doc().snapshots().map(_userFromSnapshot);
  }

  List<Fournisseurs>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Fournisseurs>> get users {
   // return userCollection.where("email",isNotEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    return userCollection.snapshots().map(_userListFromSnapshot);
  }


  getDocument(String codeFournisseur) async{
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("fournisseurs");

    Query query = collectionReference.where("codeFournisseur",isEqualTo: codeFournisseur);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['codeFournisseur']) ;

    var login=doc.toString();


    print(login.substring(1, login.length-1).toString());
    await login.toString();


  }


  Future<void> saveUser(BuildContext context,String name,String numero,String ville,String codeFournisseur) async {


    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("fournisseurs");

    Query query = collectionReference.where("codeFournisseur",isEqualTo: codeFournisseur);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['codeFournisseur']) ;

    var login=doc.toString();

    if(login.substring(1, login.length-1).toString().isEmpty){
      Navigator.of(context).pop();
      await userCollection.doc().set({'name': name,'numero':numero,'ville': ville,'codeFournisseur': codeFournisseur});
    }else{
      Future showToast(String message) async{

        await   Fluttertoast.showToast(msg: message,fontSize: 18,
          timeInSecForIosWeb:3,textColor: Colors.white,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black45,
          webPosition:"center",
        );

      }


     await showToast("Ce code fournisseur existe deja inserer un autre");
    }
  }
}