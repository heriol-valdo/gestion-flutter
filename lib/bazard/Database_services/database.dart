

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/chat_params.dart';
import '../models/user.dart';


class DatabaseService extends StatelessWidget{
  final String uid;

  DatabaseService(this.uid);

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
     // FirebaseFirestore.instance.collection("users").doc().collection("");
   //FirebaseFirestore.instance.collection("users").where(field);
  FirebaseFirestore.instance.collection("users");


  // supprime l'utilisayeur de maniere async en local er base externe
  Future<void> deleteUser() async {
     await userCollection.doc(uid).delete();
    /* await userCollection.doc(uid).collection("bordereau").doc(uid).delete();
     await userCollection.doc(uid)..collection("etat_stock").doc(uid).delete();*/

  }

 /* Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }
*/

  Future<void> saveUser(String name,String email,String telephone,String adresse,String religion,
      String etudes,String taille,String statut,String age) async {
    /* await userCollection.doc(uid).collection("etat_stock").doc(uid).set({'quantite': name});
     await userCollection.doc(uid).collection("bordereau").doc(uid).set({'quantite': name});*/
    await userCollection.doc(uid).set({'name': name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'photo':""});

  }
  AppUserData _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return AppUserData(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      telephone: data['telephone'],
      adresse: data['adresse'],
      religion: data['religion'],
      etudes: data['etudes'],
      taille: data['taille'],
      statut: data['statut'],
      age: data['age'],
      photo: data['photo'] ,
    );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
   return userCollection.where("email",isNotEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    //return userCollection.snapshots().map(_userListFromSnapshot);
  }


  Stream<List<AppUserData>> get userDrawer {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    // return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<List<AppUserData>> get userProfile {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    // return userCollection.snapshots().map(_userListFromSnapshot);
  }


   getDocument() async{
    final CollectionReference collectionReference =
    // FirebaseFirestore.instance.collection("users").doc().collection("");
    //FirebaseFirestore.instance.collection("users").where(field);
    FirebaseFirestore.instance.collection("users");

    Query query = collectionReference.where("email",isEqualTo: userUid!.email);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['name']) ;

    var login=doc.toString();


    await login.toString();

   /* String login=doc.toString();

    login=login.substring(1, login.length-1);
*/
   /* if(heriol.toString().isEmpty){
      await heriol;

      return heriol=login;
    }else{
      await heriol;
      print(heriol=login);
     return heriol=login;
    }*/


    //print(login);

   // await login;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}


class DatabaseDiscussions {

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollectionDiscussions =
  FirebaseFirestore.instance.collection("Discussions");


  getDocument(String uidDiscusions) async {

    final CollectionReference collectionReference =
    // FirebaseFirestore.instance.collection("users").doc().collection("");
    //FirebaseFirestore.instance.collection("users").where(field);
    FirebaseFirestore.instance.collection("users");

    Query query = collectionReference.where("email",isEqualTo: userUid!.email);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['name']);

    var login=doc.toString();

    await   userCollectionDiscussions.doc(userUid!.uid).set({'name':login.substring(1, login.length-1).toString(),'usercurrentuid': uidDiscusions});

  }

  Future<void> saveDiscusions(String uidDiscusions,String nameUserDiscusions) async {
    await userCollectionDiscussions.doc(uidDiscusions).set({'name': nameUserDiscusions,'usercurrentuid':userUid!.uid});
  }

  AppUserDiscussions _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("Discussions not found");
    return AppUserDiscussions(
      uid: snapshot.id,
      name: data['name'],
    );
  }

  List<AppUserDiscussions>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserDiscussions>> get usersDiscussions {
   return userCollectionDiscussions.where("usercurrentuid",isEqualTo:userUid!.uid).snapshots().map(_userListFromSnapshot);
    //return userCollectionDiscussions.snapshots().map(_userListFromSnapshot);
  }

}



class DatabaseProfile{
  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  // FirebaseFirestore.instance.collection("users").doc().collection("");
  //FirebaseFirestore.instance.collection("users").where(field);
  FirebaseFirestore.instance.collection("users");

  Future<void> saveToken(String telephone,String adresse,String religion,String etudes,String taille,String statut,String age) async {
    return await userCollection.doc(userUid!.uid).update({'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
    ,'statut': statut,'age': age});
  }

  /*Future<void> savePhoto(String name,String email,String telephone,String adresse,String religion,String etudes,String taille,String statut,String age,String photo) async {
    return await userCollection.doc(userUid!.uid).update({'name':name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'photo':photo});
  }*/

  Future<void> savePhoto(String photo) async {
    return await userCollection.doc(userUid!.uid).update({'photo':photo});
  }

  AppUserProfile _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserProfile(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      telephone: data['telephone'],
      adresse: data['adresse'],
      religion: data['religion'],
      etudes: data['etudes'],
      taille: data['taille'],
      statut: data['statut'],
      age: data['age'],
      photo: data['photo'],
    );
  }


  List<AppUserProfile>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserProfile>> get users {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    //return userCollection.snapshots().map(_userListFromSnapshot);
  }
}




/*
Ici, puisque nous utilisons le userIdcomme identifiant du document, nous utilisons donc la
méthode set()pour ajouter des données au document. Si un document existe déjà et que vous souhaitez le mettre à jour,
vous pouvez utiliser le paramètre nommé facultatif mergeet le définir sur true:

void _onPressed() {
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser.uid).set(
      {
        "username" : "userX",
      },SetOptions(merge: true)).then((_){
    print("success!");
  });
}


Remarque: set()avec merge:truemettra à jour les champs dans le document ou le créera s'il n'existe pas tandis que update()mettra à jour les champs mais échouera si le document n'existe pas

Supposons maintenant que nous souhaitons ajouter des caractéristiques pour chaque utilisateur dans Cloud Firestore, nous pouvons le faire en utilisant array:

void _onPressed() {
var firebaseUser =  FirebaseAuth.instance.currentUser;
firestoreInstance.collection("users").doc(firebaseUser.uid).update({
  "characteristics" : FieldValue.arrayUnion(["generous","loving","loyal"])
}).then((_) {
  print("success!");
});
}

Pour supprimer un champ à l'intérieur du document, vous pouvez utiliser FieldValue.delete()avec update():

void _onPressed() {
var firebaseUser =  FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser.uid).update({
  "username" : FieldValue.delete()
}).then((_) {
  print("success!");
});
}


Ainsi, comme vous pouvez le voir ci-dessus, nous n'avons pas récupéré les données de la petscollection car les requêtes sont superficielles.Par conséquent, pour récupérer les données subcollections, vous pouvez effectuer les opérations suivantes:

void _onPressed() {
firestoreInstance.collection("users").get().then((querySnapshot) {
  querySnapshot.docs.forEach((result) {
    firestoreInstance
        .collection("users")
        .doc(result.id)
        .collection("pets")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  });
});
}\


void _onPressed() async {
  var result = await firestoreInstance
      .collection("countries")
      .where("countryName", whereIn: ["italy","lebanon"])
      .get();
  result.docs.forEach((res) {
    print(res.data());
  });
}
view raw
or.dart hosted with ❤ by GitHub

Cela renverra chaque document où countryNameest soit italyou lebanon.

*/
