// la classe qui gere la constitution du fichier utilisateur



import 'package:camera/camera.dart';

class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final  String uid;
  final String name;
  final String email;
  final String telephone;
  final String adresse;
  final String religion;
  final String etudes;
  final String taille;
  final String statut;
  final String age;
  final String photo;

  AppUserData({required this.uid,required this.name,required this.email,required this.telephone,
    required this.adresse,required this.religion,required this.etudes,required this.taille,required this.statut,required this.age,required this.photo});

}

class AppUserDiscussions{
final  String uid;
 final String name;

  AppUserDiscussions({required this.uid,required this.name});
}

class AppUserProfile{
  final  String uid;
  final String name;
  final String email;
  final String telephone;
  final String adresse;
  final String religion;
  final String etudes;
  final String taille;
  final String statut;
  final String age;
  final String photo;

  AppUserProfile({required this.uid,required this.name,required this.email,required this.telephone,
  required this.adresse,required this.religion,required this.etudes,required this.taille,required this.statut,required this.age,required this.photo});


}





