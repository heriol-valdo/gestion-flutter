import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_firebase/bazard/Database_services/database.dart';
import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/gestion/Database_service/database_fournisseurs.dart';
import 'package:flutter_firebase/bazard/models/user.dart';
import 'package:flutter_firebase/gestion/Model/AppUserId.dart';
import 'package:flutter_firebase/gestion/Model/fournisseurs_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../bazard/View_page/Profile/ParamsUser.dart';
import '../../bazard/View_page/Profile/PrafileUser.dart';
import '../Database_service/authentication.dart';



class FournisseursList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<FournisseursList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Fournisseurs>>(context);


    final  name = TextEditingController();
    final  numero = TextEditingController();
    final  ville = TextEditingController();
    final  codeFournisseur = TextEditingController();
    final _formKey = GlobalKey<FormState>();


    void toggleView() {
      setState(() {
        _formKey.currentState?.reset();// on vide le contenu dans le formulaire
        name.text = '';
       numero.text = '';
        ville.text = '';
        codeFournisseur.text = '';

      });
    }


    Future<void> dialogsuppresion(BuildContext context) async {

      await  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" element supprimé"))).closed;
    }
    Future<void> createDialog()async {CupertinoAlertDialog(
      title: Text(
        'Suppresion client',
        style: TextStyle(fontSize: 22),
      ),
      content:Text(
        'voulez vous vraiment supprimer ce client?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Yes'),
          onPressed: (){
            dialogsuppresion(context);
            Navigator.pop(context,true);
          },
        ),

        CupertinoDialogAction(
          child: Text('No'),
          onPressed: (){
            Navigator.pop(context,false);
          },)
      ],
      //backgroundColor:Colors.blue,
      //   elevation: 24.0,
      // shape: CircleBorder(),

    );}
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
                      child:Text("Enregistrer un nouveau fournisseur" ,style: TextStyle(fontSize: 25),),
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    TextFormField(
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
                          labelText: "Nom Fournisseur",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer un nom fournisseur",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty && value.length<4){
                            return "Veuillez saisir un nom fournisseur(quatre lettres minimun)";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: numero,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.numbers),
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
                          labelText: "Numero Fournisseur",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer  un numero fournisseur",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty || value.length<9){
                            return 'Veuillez saisir un numero(9 chiffres minimun)';
                          }
                          return null;
                        }

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller:ville,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.account_balance_rounded),
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
                        labelText: "Ville",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer la ville du fournisseur",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty || value.length<4) {
                          return 'veuillez entrer une ville(quatre lettres minimun)';
                        }
                        return null;
                      },
                    ),
                   const SizedBox(height: 15),
                    TextFormField(
                      controller:codeFournisseur,
                      obscureText: false,
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
                        labelText: "Code Fournisseur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer un code fournisseur",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'veuillez entrer un code fournisseur';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),


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
                          var numeroT=numero.value.text;
                          var villeT=ville.value.text;
                          var codeFournisseurT=codeFournisseur.value.text;


                          final database_fournisseurs  = DatabaseFournisseurs();


                          dynamic result =  database_fournisseurs.saveUser(context,nameT,numeroT, villeT,codeFournisseurT);


                          if(result!=null){
                            //  toggleView();
                         //   Navigator.of(context).pop();
                          }

                          if (result == null ) {
                            Future showToast(String message) async{

                              await   Fluttertoast.showToast(msg: message,fontSize: 18,
                                timeInSecForIosWeb:3,textColor: Colors.white,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.black45,
                                webPosition:"center",
                              );

                            }
                            //  loading = false;
                              showToast("verifier votre etat de connexion");

                          };

                        }


                      },
                      child: Text("Enregistrer"),
                    )
                  ],
                ),
              ),

            )
        );
      });

    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 20,color: Colors.white,),
        backgroundColor:Colors.blueAccent ,
        foregroundColor:Colors.blueAccent ,
        focusColor: Colors.blueAccent,
        focusElevation:2 ,
        onPressed:(){
         Modal(context);
        } ,
        elevation: 2,
      ),
      body:ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return UserTitleState(users[index]);
        }
    ),
    );
  }
}




class UserTitleState extends StatelessWidget{
  final Fournisseurs user;

   UserTitleState(this.user);


   Future <void> suppressionFournisseur(BuildContext context) async{
    showCupertinoDialog(
        barrierDismissible: true,//quitter le dialog en cliquant a cote
        context: context,
        builder: createDialog
    );
  }
  Future<void> dialogsuppresion(BuildContext context) async {

    await  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("le fournisseur "+user.name +" supprimé"))).closed;
  }
  Widget createDialog(BuildContext context)=>CupertinoAlertDialog(
    title: Text(
      'Suppresion Fournisseurs',
      style: TextStyle(fontSize: 22),
    ),
    content:Text(
      'voulez vous vraiment supprimer ce fournisseur?',
      style: TextStyle(fontSize: 16),
    ),
    actions: [
      CupertinoDialogAction(
        child: Text('oui'),
        onPressed: (){
          final database_fournisseurs  = DatabaseFournisseurs();
         database_fournisseurs.deleteUser(user.uid);
          dialogsuppresion(context);
          Navigator.pop(context,true);
        },
      ),

      CupertinoDialogAction(
        child: Text('non'),
        onPressed: (){
          Navigator.pop(context,false);
        },)
    ],
    //backgroundColor:Colors.blue,
    //   elevation: 24.0,
    // shape: CircleBorder(),

  );


  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUserId?>(context);
    if (currentUser == null) throw Exception("current user not found");

    final  name = TextEditingController();
    final  numero = TextEditingController();
    final  ville = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future showToast(String message) async{
      //   await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);

    }

    void toggleView() {
      _formKey.currentState?.reset();// on vide le contenu dans le formulaire
      name.text = '';
      numero.text = '';
      ville.text = '';

    }
    void Modal(BuildContext context) async{


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
              bottom:30,

            ),
            child:Form(
              key: _formKey,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child:Text("Modifier le fournisseur  "+user.name ,style: TextStyle(fontSize: 25),),
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  TextFormField(
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
                        labelText: "Nom fournisseur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer un nouveau nom  ",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty && value.length<4){
                          return "Veuillez saisir un nom fournisseur(quatre lettres minimun)";
                        }
                        return null;
                      }

                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: numero,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.numbers),
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
                        labelText: "Numero Fournisseur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer  un nouveau numero ",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty || value.length<9){
                          return 'Veuillez saisir un numero(9 chiffres minimun)';
                        }
                        return null;
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:ville,
                    obscureText: false,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.account_balance_rounded),
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
                      labelText: "Ville",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer la nouvelle  ville ",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || value.length<4) {
                        return 'veuillez entrer une ville(quatre lettres minimun)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(

                    padding:EdgeInsets.all(4),
                    child:  Container(
                      height: 45,
                      width: 600,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(user.codeFournisseurs,style: TextStyle(fontSize: 12),),
                    ),),

                  const SizedBox(height: 20,),


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
                        var numeroT=numero.value.text;
                        var villeT=ville.value.text;



                        final database_fournisseurs  = DatabaseFournisseurs();

                        dynamic result =  database_fournisseurs.updateFournisseurs(context,user.uid,nameT,numeroT, villeT);

                        toggleView();
                          Navigator.pop(context,true);


                          if(result!=null){
                            Navigator.of(context).pop();
                          }



                        if (result == null ) {
                          //  loading = false;
                          //   showToast("veuillez entrer un email et mot de passe valide") ;

                        };

                      }


                    },

                    child: Text("Modifier"),
                  )
                ],
              ),
            ),

          )
      );




    }





    return Slidable(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Card(
              //elevation: 8.0,
              //  margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
              child: ListTile(
                title: Text(user.name),
                subtitle:  Text(' ${user.ville}'),
              ),
            ),
          ),
          key: const ValueKey(0),

          startActionPane: ActionPane(
            motion: const StretchMotion(),
            /*dismissible:  DismissiblePane(
              key: Key(user.name),
              onDismissed: (){

                  showCupertinoDialog(
                      barrierDismissible: true,//quitter le dialog en cliquant a cote
                      context: context,
                      builder: createDialog
                  );
                  //   database.deleteUser();

                //  ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text("${date['name']} supprimé")));
              },

              //  background: Container(color: Colors.blueGrey),
              //  child: Container(),

            ),*/
            children: [
              SlidableAction(
                onPressed:suppressionFournisseur,
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),

            ],


          ),
          endActionPane:ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: Modal,
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.more_horiz,
                label: 'Modifier',
              ),
            ],
          ),
        ) ;


  }
}





