import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/gestion/list_view/article_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/article_model.dart';

class DatabaseArticle{

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  FirebaseFirestore.instance.collection("article");




  // supprime l'utilisayeur de maniere async en local er base externe
  Future<void> deleteUser(String user) async {
    await userCollection.doc(user).delete();


  }

  getDocument(String codeArticle) async{
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['codeArticle']) ;

    var login=doc.toString();


    print(login.substring(1, login.length-1).toString());
    await login.toString();


  }

  Future<void> updateArticle(BuildContext context,String user,String name,String categorie,String description) async {

    await userCollection.doc(user).update({'name': name,'categorie':categorie,'description': description});
    //Navigator.of(context).pop();
  }

  Future<void> updateQuantiteArticleEntrer(BuildContext context,String user,String codeArticle,String ValeurEntrer) async {

    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['quantite']) ;

    var login=doc.toString();

    var Parentese=login.substring(1, login.length-1).toString();

    print(Parentese);

   int ValeurEntrerConverti= int.parse(ValeurEntrer);

   int valeurRecuprerEndate=int.parse(Parentese);

   int SommeValeur=valeurRecuprerEndate+ValeurEntrerConverti;;



    await userCollection.doc(user).update({'quantite':SommeValeur.toString()});
  //  Navigator.of(context).pop();
    print(SommeValeur);

    await  updateQuantiteEntrerInventaire(context, user, codeArticle, ValeurEntrer);
  }

  Future<void>updateQuantiteEntrerInventaire(BuildContext context,String user,String codeArticle,String ValeurEntrer) async{

    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['Sentrer']) ;

    var login=doc.toString();

    var Parentese=login.substring(1, login.length-1).toString();

    print(Parentese);

    int ValeurEntrerConverti= int.parse(ValeurEntrer);

    int valeurRecuprerEndate=int.parse(Parentese);

    int SommeValeur=valeurRecuprerEndate+ValeurEntrerConverti;;



    await userCollection.doc(user).update({'Sentrer':SommeValeur.toString()});
    Navigator.of(context).pop();
    print(SommeValeur);


  }


  Future<void> updateQuantiteArticleSortie(BuildContext context,String user,String codeArticle,String ValeurEntrer) async {

    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['quantite']) ;

    var login=doc.toString();

    var Parentese=login.substring(1, login.length-1).toString();

    print(Parentese);

    int ValeurEntrerConverti= int.parse(ValeurEntrer);

    int valeurRecuprerEndate=int.parse(Parentese);




    if(ValeurEntrerConverti>valeurRecuprerEndate){
      Future showToast(String message) async {
        await Fluttertoast.showToast(msg: message,
          fontSize: 18,
          timeInSecForIosWeb: 3,
          textColor: Colors.white,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black45,
          webPosition: "center",
        );
      }
      showToast("nous ne pouvons effectuer cette operation car la valeur en stock est inferieur a la valeur sortie");

    }else{
      int SommeValeur=valeurRecuprerEndate-ValeurEntrerConverti;;
      await userCollection.doc(user).update({'quantite':SommeValeur.toString()});
      await updateQuantiteSortieInventaire(context, user, codeArticle, ValeurEntrer);
      Navigator.of(context).pop();
      print(SommeValeur);
    }



  }

  Future<void>updateQuantiteSortieInventaire(BuildContext context,String user,String codeArticle,String ValeurEntrer) async{

    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['Ssortie']) ;

    var login=doc.toString();

    var Parentese=login.substring(1, login.length-1).toString();

    print(Parentese);

    int ValeurEntrerConverti= int.parse(ValeurEntrer);

    int valeurRecuprerEndate=int.parse(Parentese);

    int SommeValeur=valeurRecuprerEndate+ValeurEntrerConverti;;



    await userCollection.doc(user).update({'Ssortie':SommeValeur.toString()});
    Navigator.of(context).pop();
    print(SommeValeur);


  }

  Future<void> saveUser(BuildContext context,String name,String categorie,String description,String codeArticle,String codeFournisseur) async {
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("article");

    Query query = collectionReference.where("codeArticle",isEqualTo: codeArticle);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['codeArticle']) ;

    var login=doc.toString();

    print(login.substring(1, login.length-1).toString());

    final CollectionReference collectionReferenceFournisseur =
    FirebaseFirestore.instance.collection("fournisseurs");

    Query queryFournisseur = collectionReferenceFournisseur.where("codeFournisseur",isEqualTo: codeFournisseur);

    QuerySnapshot querySnapshotFounisseur = await queryFournisseur.get();

    final docFournisseur = querySnapshotFounisseur.docs.map((doc) => doc['codeFournisseur']) ;

    var loginFournisseur=docFournisseur.toString();

    print(loginFournisseur.substring(1, loginFournisseur.length-1).toString());


    if(login.substring(1, login.length-1).toString().isEmpty && loginFournisseur.substring(1, loginFournisseur.length-1).toString().isNotEmpty){
      Navigator.of(context).pop();
      await userCollection.doc().set({'name':name,'categorie':categorie,'description':description,'quantite':"0",'Ssortie':"0",'Sentrer':"0",'Ssolde':"0",'codeArticle':codeArticle,'codeFournisseur': codeFournisseur});

    }else{

       Future showToast(String message) async {
        await Fluttertoast.showToast(msg: message,
          fontSize: 18,
          timeInSecForIosWeb: 3,
          textColor: Colors.white,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black45,
          webPosition: "center",
        );
      }

       if(login.substring(1, login.length-1).toString().isNotEmpty){
        await showToast("Ce code article existe deja inserer un autre");
         }

        else if(loginFournisseur.substring(1, loginFournisseur.length-1).toString().isEmpty){
        await showToast("Ce code fournisseur n'existe pas inserer un autre");

      }

    }
  }




  Article _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return Article(
      uid: snapshot.id,
      name: data['name'],
      categorie: data['categorie'],
      description: data['description'],
      quantite: data['quantite'],
        Ssortie: data['Ssortie'],
        Sentrer: data['Sentrer'],
      codeArticle:data['codeArticle'],
      codeFournisseurs: data['codeFournisseur']
    );
  }

  Stream<Article> get user {
    return userCollection.doc().snapshots().map(_userFromSnapshot);
  }

  List<Article>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Article>> get users {
   // return userCollection.where("email",isNotEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    return userCollection.snapshots().map(_userListFromSnapshot);
  }




}