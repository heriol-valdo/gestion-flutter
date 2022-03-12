import 'package:flutter/material.dart';

import '../../gestion/Database_service/authentication.dart';
import '../common/constants.dart';
import '../../gestion/loading_circular/loading.dart';


// la classe qui gere la page d'authentification avec ces contours

// tout d'abord on creer la classe en statefullwidgwt car la classe changera en cours d;utilisation de l;application
class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

// on l'instancie en state
class _AuthenticateScreenState extends State<AuthenticateScreen> {
  // on instancie un nouvel objet d'authentification ou d'enregistrement  a firebase
  final AuthenticationService _auth = AuthenticationService();
  // on instancie les differentes variable utiliser dans le programme
  final _formKey = GlobalKey<FormState>();//variable qui verifie si le formulaire est correct
  String error = '';// variable qui assigne un message d'erreur
  bool loading = false;// variable qui determiner l;etat du loader

  //on creer les elements du formulaire
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    ageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();// on vide le contenu dans le formulaire
      error = '';
      emailController.text = '';
      nameController.text = '';
      ageController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(// on initialise appbar en fonction la vue souhaiter
              backgroundColor: Colors.blueGrey,
              elevation: 0.0,
              title: Text(showSignIn ? 'Sign in to Water Social' : 'Register to Water Social'),//le titre le l'appbar depend du booleen,ici si showsign est egal a vrai il ecrit sign si non register
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(showSignIn ? "Register" : 'Sign In',//pareil ici pour le titre du textbottom
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => toggleView(),//quand on appui dessus on reinitialise le contenu des champs en les mettants a vide
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    !showSignIn//si showsignin est differents de son contenu donc false alors affiche le TextFormfield ci
                        ? TextFormField(
                            controller: nameController,
                            decoration: textInputDecoration.copyWith(hintText: 'name'),
                            validator: (value) =>
                                value == null || value.isEmpty ? "Enter a name" : null,
                          )
                        : Container() ,
                    !showSignIn ? SizedBox(height: 10.0) : Container(),//si showsign est different de son contenu alors met l'espace entre deux object si non contenair vide
                    !showSignIn
                        ? TextFormField(
                      controller: ageController,
                      decoration: textInputDecoration.copyWith(hintText: 'age'),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter a age" : null,
                    )
                        : Container() ,
                    !showSignIn ? SizedBox(height: 10.0) : Container(),
                    TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(hintText: 'email'),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter an email" : null,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (value) => value != null && value.length < 6
                          ? "Enter a password with at least 6 characters"
                          : null,
                    ),
                    SizedBox(height: 10.0),
                    // on place un boutoon register ou sign en foction de son utilisation
                    ElevatedButton(
                      child: Text(
                        showSignIn ? "Sign In" : "Register",//ici si showsign est egal a true alors sign si non register
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // si tout les element qui sont contenu dans le formulaires courant sont vrai passe loading a true
                        if (_formKey.currentState?.validate() == true) {
                          setState(() => loading = true);

                          // on recupere les elements contenu dans dans les TextFormfield
                          var password = passwordController.value.text;
                          var email = emailController.value.text;
                          var name = nameController.value.text;
                          var age = ageController.value.text;


                          dynamic result = showSignIn
                          //on attribut la valeur de showsignin a result et valeur  par defaut true donc on aura seulement email et password a rechercher
                          // si non on insert les elements du formulaires
                              ? await _auth.signInWithEmailAndPassword(email, password)
                              : await _auth.registerWithEmailAndPassword(name,age, email, password);
                          if (result == null ) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }



}
