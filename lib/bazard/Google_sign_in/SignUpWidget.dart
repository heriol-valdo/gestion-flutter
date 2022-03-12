import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../gestion/Database_service/authentication.dart';
import 'GoogleSignInApi.dart';


class SignUpWidget extends StatefulWidget {

  _SignUpWidget createState() => _SignUpWidget();
}
class _SignUpWidget extends State<SignUpWidget>{
  final AuthenticationService _auth = AuthenticationService();
  bool etatText = true;
  bool etatSexe=true;
  int index = 0;

  // element de la modal
  List<String> values = [
    'Homme',
    'Femme',
  ];

   String dropdowSexe='Homme';
 
  final  name = TextEditingController();
  final  email = TextEditingController();
  final  password = TextEditingController();
  final  passwordV = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();// on vide le contenu dans le formulaire
       error = '';
      name.text = '';
      email.text = '';
      password.text = '';
      passwordV.text = '';

    });
  }

  Widget buildCustomPicker() => SizedBox(
    height: 200,
    child: CupertinoPicker(
      itemExtent: 64,
      // diameterRatio: 0.7,
      //pour que les elements du tableau s'arrete au dernier
      looping:false,
      onSelectedItemChanged: (index) => this.index = index,
      // selectionOverlay: Container(),
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Colors.pink.withOpacity(0.12),
      ),
      children: modelBuilder<String>(
          values,
              (index, value) {
            final isSelected = this.index == index;
            final color = isSelected ? Colors.pink : Colors.white;

            return Center(
              child: Text(
                value,
                style: TextStyle(color: color, fontSize: 24),
              ),
            );
          },
        ),
    ),
  );

  static List<Widget> modelBuilder<M>(List<M> models, Widget Function(int index, M model) builder) {
   return models
        .asMap()
        .map<int, Widget>(
            (index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
  }

  void showSheet(BuildContext context, {required Widget child,}) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          CupertinoActionSheet(
            actions: [
              buildCustomPicker(),
            ],

            cancelButton: CupertinoActionSheetAction(
              child: Text('Selection'),
              onPressed: () {
                final value = values[index];
                if(value=="Homme"){
                  etatSexe=true;
                }else if(value=="Femme"){
                  etatSexe=false;
                }
                //  showSnackBar(context, 'Selected "$value"');
                print('Selected "$value"');

                //  print("heriol");

                Navigator.of(context).pop();
              },
            ),
          ),


    );
  }

  void Modal(BuildContext context) async{
    setState(() {
      showModalBottomSheet(
        // couleur de fond sur le reste de l'ecran l'orsque la modal monte
          barrierColor: Colors.white70,
          // backgroundColor: Colors.blueAccent,
          // donne la possibilite de scroller
          enableDrag: true,
          isDismissible:true,
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
          ) ,
          context:context,
          // se souleve paraport au bas
          elevation: 30,
          isScrollControlled: true,
          builder: (_) => Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.only(
              top: 50,
              left: 50,
              right:50,
              // this will prevent the soft keyboard from covering the text fields
              // bottom: MediaQuery.of(context).viewPadding.bottom + 150,
              bottom:30,

            ),
            child:Form(
              key: _formKey,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child:Text(etatText?"Se connecter" : "S'incrire" ,style: TextStyle(fontSize: 25),),
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  etatText?Container(): TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.account_circle_rounded),
                            padding: EdgeInsets.all(8)
                        ),
                        // en cas d'erreur les bordure devienne rouge
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        //filled: true,
                        fillColor: Colors.white,
                        labelText: "Nom utilisateur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer un nom d'utilisateur",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty && value.length<4){
                          return "Veuillez saisir un nom d'utilisateur(quatre lettres minimun)";
                        }
                        return null;
                      }

                  ),

                  etatText? Container():const SizedBox(height: 15,),

                  etatText?Container():  Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:  DropdownButton<String>(
                        isExpanded: true,
                        // dropdownColor: Colors.grey,
                        hint: Text("selectionner un sexe"),
                        value: dropdowSexe,
                        icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                        elevation:10,
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                        onChanged: (String? newvalue){
                          setState(() {
                            dropdowSexe=newvalue!;
                          });
                        },
                        items: <String>['Homme','Femme'].map<DropdownMenuItem<String>>((String value){
                          return
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                        }).toList()


                    ),
                  ),
                  etatText? Container():const SizedBox(height: 15,),
                  TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.markunread),
                            padding: EdgeInsets.all(8)
                        ),
                        // en cas d'erreur les bordure devienne rouge
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        //filled: true,
                        fillColor: Colors.white,
                        labelText: "Email",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer votre Email",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty){
                          return 'Veuillez saisir un Email valide';
                        }
                        return null;
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:password,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.visibility_off_sharp),
                          padding: EdgeInsets.all(8)
                      ),
                      // en cas d'erreur les bordure devienne rouge
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),

                      //filled: true,
                      fillColor: Colors.white,
                      labelText: "mot de passe",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer votre mot de passe",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || value.length<6) {
                        return 'veuillez entrer au moins 6 characteres';
                      }
                      return null;
                    },
                  ),
                  etatText? Container():const SizedBox(height: 15),

                  etatText?Container():TextFormField(
                    controller:passwordV,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.vpn_key_rounded),
                          padding: EdgeInsets.all(8)
                      ),
                      // en cas d'erreur les bordure devienne rouge
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      //filled: true,
                      fillColor: Colors.white,
                      labelText: "mot de passe de verification",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "verifier le mot de passe",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value){
                      if(value!=password.value.text) {
                        return 'veuillez entrer le meme mot de passe';
                      }
                      return null;
                    },
                  ),
                  etatText? Container():const SizedBox(height: 20,),


                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                      minimumSize: Size(double.infinity,50),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState?.validate() == true) {

                        // on recupere les elements contenu dans dans les TextFormfield
                        var nameT=name.value.text;
                        var ageT=email.value.text;
                        var emailT=email.value.text;
                        var passwordT=password.value.text;

                        dynamic result = etatText
                        //on attribut la valeur de showsignin a result et valeur  par defaut true donc on aura seulement email et password a rechercher
                        // si non on insert les elements du formulaires
                            ? await _auth.signInWithEmailAndPassword(emailT, passwordT)
                            : await _auth.registerWithEmailAndPassword(nameT,ageT, emailT, passwordT);


                        if(result!=null){
                          etatText ? Navigator.of(context).pop() : Navigator.of(context).pop();
                        }

                        if (result == null ) {
                          //  loading = false;
                          etatText? showToast("veuillez entrer un email et mot de passe valide") : showToast("Ce mail est invalide ou il doit deja etre utiliser");

                        };

                      }
                      // Close the bottom sheet

                    },
                    child: Text(etatText ? "connecter" : "inscription"),
                  )
                ],
              ),
            ),

          )
      );
    });

  }

  Future showToast(String message) async{

    await   Fluttertoast.showToast(msg: message,fontSize: 18,
      timeInSecForIosWeb:3,textColor: Colors.white,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black45,
      webPosition:"center",
    );

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(32),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Column(
            children: [
              FaIcon(FontAwesomeIcons.mailBulk,size: 120,color: Colors.blueAccent,),
              SizedBox(height:0),
              Align(
                alignment:  Alignment.center,
                child: Text(
                    'chat me',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:30,
                      fontWeight: FontWeight.w100,
                    )
                ),
              ),
            ],
          ),
          ),

          //FlutterLogo(size: 120),
          Spacer(),
          Center(
            child:Align(
            alignment:  Alignment.center,
            child: Text(
              'Bienvenue',
              style: TextStyle(
                color: Colors.white,
                fontSize:17,
                fontWeight: FontWeight.w500,
              )
            ),
          ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Chat me est le meilleur lieu pour faire des recontres!',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(height:25),
          Container(
            child:  ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity,50),
              ),
              icon: FaIcon(FontAwesomeIcons.mailBulk,color: Colors.white,),
              label: Text('Email & Mot de passe'),
              onPressed: (){
                toggleView();
                Modal(context);
                etatText=true;
              },
            ),
          ),

          SizedBox(height: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity,50),
            ),
            icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
            label: Text('Connection avec Google'),
            onPressed: (){

             signIn();
            },
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              minimumSize: Size(double.infinity,50),
            ),
            child:TextButton(
              onPressed: () {
              Modal(context);
              etatText=false;
              },
              child:RichText(
                text: TextSpan(
                  text: "S'inscrire",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            onPressed: (){
              toggleView();
              Modal(context);
              etatText=false;
            },
          ),
          SizedBox(height: 100),

          InkWell(
            onTap: (){
              setState(() {
                toggleView();
                Modal(context);
                etatText=true;
              });

            },
              child: RichText(

              text: TextSpan(
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w100),
                text: 'Vous avez deja un compte ?  ',
                children: [
                  TextSpan(
                    text: 'Connectez-vous ici.',
                    style: TextStyle(decoration: TextDecoration.underline,color: Colors.white,fontWeight: FontWeight.w500),
                  ),
                ],
          ),
            )
          )
        ],
      ),
    );
  }

  Future signIn() async{
    await GoogleSignInApi.login();
  }

}




