import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Database_service/authentication.dart';
import '../../bazard/common/constants.dart';
import '../loading_circular/loading.dart';


// la classe qui gere la page d'authentification avec ces contours

// tout d'abord on creer la classe en statefullwidgwt car la classe changera en cours d;utilisation de l;application
class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

// on l'instancie en state
class _AuthenticateScreenState extends State<AuthenticatePage> {
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
        title: Text(showSignIn ? 'Se connecter' : "S'enregistrer"),//le titre le l'appbar depend du booleen,ici si showsign est egal a vrai il ecrit sign si non register
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(showSignIn ? "S'enregistrer" : ' Se connecter',//pareil ici pour le titre du textbottom
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
                decoration: textInputDecoration.copyWith(hintText: 'nom'),
                validator: (value) =>
                value == null || value.isEmpty ? "Entrez un nom valide " : null,
              )
                  : Container() ,
              !showSignIn ? SizedBox(height: 10.0) : Container(),//si showsign est different de son contenu alors met l'espace entre deux object si non contenair vide
              !showSignIn
                  ? TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: textInputDecoration.copyWith(hintText: 'numero'),
                  validator:(value){
                    if(value!.isEmpty || value.length<9){
                      return "Veuillez saisir un numero(9 chiffres)";
                    }
                    return null;
                  }
              )
                  : Container() ,
              !showSignIn ? SizedBox(height: 10.0) : Container(),
              TextFormField(
                controller: emailController,
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (value) =>
                value == null || value.isEmpty ? "Entrez un  email valide" : null,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(hintText: 'Mot de passe'),
                obscureText: true,
                validator: (value) => value != null && value.length < 6
                    ? "Entrez un mot de passe d'au moins 6 characters"
                    : null,
              ),
              SizedBox(height: 10.0),
              // on place un boutoon register ou sign en foction de son utilisation
              ElevatedButton(
                child: Text(
                  showSignIn ? "Connecter" : "Enregistrer",//ici si showsign est egal a true alors sign si non register
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

                    dynamic result = showSignIn
                    //on attribut la valeur de showsignin a result et valeur  par defaut true donc on aura seulement email et password a rechercher
                    // si non on insert les elements du formulaires
                        ? await _auth.signInWithEmailAndPassword(email, password)
                        : await _auth.registerWithEmailAndPassword(name,age, email, password);
                    if (result == null ) {
                      setState(() {
                        loading = false;
                        error = 'Ce mail est invalide ou il doit deja etre utiliser ou verifier votre acces a internet';
                      final  error2 = 'veuillez entrer un email et mot de passe valide  ou verifier votre acces a internet';
                      showSignIn ?  showToast(error2) : showToast(error);

                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10.0),

            ],
          ),
        ),
      ),
    );
  }



}
