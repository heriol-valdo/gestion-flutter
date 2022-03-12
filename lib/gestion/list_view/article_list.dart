import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_firebase/bazard/Database_services/database.dart';
import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/gestion/Database_service/database_article.dart';
import 'package:flutter_firebase/bazard/models/user.dart';
import 'package:flutter_firebase/gestion/Model/AppUserId.dart';
import 'package:flutter_firebase/gestion/Model/article_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../bazard/View_page/Profile/ParamsUser.dart';
import '../../bazard/View_page/Profile/PrafileUser.dart';
import '../Database_service/authentication.dart';
import '../Database_service/database_fournisseurs.dart';



class ArticleList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<ArticleList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Article>>(context);

    final  name = TextEditingController();
    final  description = TextEditingController();
    final  categorie = TextEditingController();
    final  codeArtcile = TextEditingController();
    final  codeFournisseur = TextEditingController();
    final  QuantiteArticleEntrer = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String error = '';

    void toggleView() {
      setState(() {
        _formKey.currentState?.reset();// on vide le contenu dans le formulaire
        error = '';
        name.text = '';
        description.text = '';
        categorie.text = '';
        codeArtcile.text = '';
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
                      child:Text("Enregistrer un nouvelle Article" ,style: TextStyle(fontSize: 25),),
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.fastfood),
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
                          labelText: "Nom Article",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer un nom article",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty && value.length<4){
                            return "Veuillez saisir un nom article(quatre lettres minimun)";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                        controller: categorie,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.cases),
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
                          labelText: "Nom Caegories",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer une categorie",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty){
                            return "Veuillez saisir une categorie";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                        controller:description,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.description),
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
                          labelText: "Description",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer  une description",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty){
                            return 'Veuillez saisir une description';
                          }
                          return null;
                        }

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller:codeArtcile,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.numbers_rounded),
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
                        labelText: "Code Article",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer un code article",hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty || value.length<4) {
                          return 'veuillez entrer un code article';
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
                        labelText: "Code Fournisseur Associe a l'Article",labelStyle: TextStyle(color: Colors.blueAccent),
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
                          var categorieT=categorie.value.text;
                          var descriptionT=description.value.text;
                          var codeArticleT=codeArtcile.value.text;
                          var codeFournisseurT=codeFournisseur.value.text;


                          final database_article  = DatabaseArticle();

                         database_article.getDocument(codeFournisseurT);
                          dynamic result =  database_article.saveUser(context,nameT,categorieT, descriptionT,codeArticleT,codeFournisseurT);


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
          setState(() {
           Modal(context);
          });

        } ,
        elevation: 2,
        /*shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
       ),*/

      ),
      body: ListView.builder(
          itemCount:users.length,
          itemBuilder: (context, index) {
            return UserTitle(users[index]);
          }
      ),
    );
  }
}



class UserTitle extends StatelessWidget {
  final  Article user;
  UserTitle(this.user);

  final  name = TextEditingController();
  final  description = TextEditingController();
  final  categorie = TextEditingController();
  final  codeArtcile = TextEditingController();
  final  codeFournisseur = TextEditingController();
  final  QuantiteArticleEntrer = TextEditingController();
  final  QuantiteArticleSortir = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void toggleView() {

    _formKey.currentState?.reset();// on vide le contenu dans le formulaire
    name.text = '';
    description.text = '';
    categorie.text = '';
    codeArtcile.text = '';
    codeFournisseur.text = '';
    QuantiteArticleEntrer.text='';
    QuantiteArticleSortir.text='';
  }

  void dispose() {
    QuantiteArticleEntrer.dispose();
    QuantiteArticleSortir.dispose();

  }

  void ModalSortir(BuildContext context) async{

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
        elevation: 130,
        isScrollControlled: true,
        builder: (_) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.only(
            top: 150,
            left: 50,
            right:50,
            // this will prevent the soft keyboard from covering the text fields
            // bottom: MediaQuery.of(context).viewPadding.bottom + 150,
            bottom:180,

          ),
          child:Form(
            key: _formKey,
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child:Text("Quantite a Sortir au stock de l'article  " + user.name ,style: TextStyle(fontSize:18),),
                ),
                const SizedBox(
                  height:20,
                ),
                TextFormField(
                    controller: QuantiteArticleSortir,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.fastfood),
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
                      labelText: "Quantite Article",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer  la quantite a sortir",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:(value){
                      if(value!.isEmpty ){
                        return "Veuillez saisir une valeur";
                      }
                      return null;
                    }

                ),
                const SizedBox(
                  height:10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity,50),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState?.validate() == true) {

                      // on recupere les elements contenu dans dans les TextFormfield
                      var ValeurSortirT=name.value.text;

                      final database_article  = DatabaseArticle();

                      dynamic result =  database_article.updateQuantiteArticleSortie(context,user.uid,user.codeArticle,ValeurSortirT);
                      toggleView();

                  //    Navigator.pop(context,true);



                      if(result!=null){
                        Navigator.of(context).pop();
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

                      dispose();

                    }


                  },
                  child: Text("Enregistrer"),
                ),
                const SizedBox(
                  height:100,
                ),
                Container(
                  width: 10,
                  child: Text("15"),
                  height: 100,
                )
              ],
            ),
          ),

        )
    );


  }

  void ModalUpdate(BuildContext context) async{

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
                  child:Text("Modifier l'article  " + user.name ,style: TextStyle(fontSize: 25),),
                ),
                const SizedBox(
                  height:20,
                ),
                TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.fastfood),
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
                      labelText: "Nom Article",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer un nouveau nom d'article",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:(value){
                      if(value!.isEmpty && value.length<4){
                        return "Veuillez saisir un nom article(quatre lettres minimun)";
                      }
                      return null;
                    }

                ),
                const SizedBox(height: 15,),
                TextFormField(
                    controller: categorie,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.cases),
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
                      labelText: "Nom Caegories",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer  nouvelle categorie",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:(value){
                      if(value!.isEmpty){
                        return "Veuillez saisir une categorie";
                      }
                      return null;
                    }

                ),
                const SizedBox(height: 15,),
                TextFormField(
                    controller:description,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.description),
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
                      labelText: "Description",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer  une nouvelle description",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:(value){
                      if(value!.isEmpty){
                        return 'Veuillez saisir une description';
                      }
                      return null;
                    }

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(

                  padding:EdgeInsets.all(0),
                  child:  Container(
                    height:45,
                    width: 600,
                    padding: EdgeInsets.only(left:27),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:Row(
                      children: [
                        Text("Code Article :     ",style: TextStyle(fontSize: 16),),
                        Text(user.codeArticle,style: TextStyle(fontSize: 14),)
                      ],),
                  ),),
                const SizedBox(height: 15),
                Padding(

                  padding:EdgeInsets.all(4),
                  child:  Container(
                    height: 45,
                    width: 600,
                    padding: EdgeInsets.only(left: 27),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text("Code Fournisseur :     ",style: TextStyle(fontSize: 16),),
                        Text(user.codeFournisseurs,style: TextStyle(fontSize: 14),)
                      ],),
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
                      var categorieT=categorie.value.text;
                      var descriptionT=description.value.text;



                      final database_article  = DatabaseArticle();

                      dynamic result =  database_article.updateArticle(context,user.uid,nameT,categorieT, descriptionT);
                      toggleView();
                      Navigator.pop(context,true);


                      if(result!=null){
                        Navigator.of(context).pop();
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


  }

  void ModalEntrer(BuildContext context) async{

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
                  child:Text("Quantite a ajouter au stock de l'article  " + user.name ,style: TextStyle(fontSize:18),),
                ),
                const SizedBox(
                  height:20,
                ),
                TextFormField(
                    controller:  QuantiteArticleEntrer,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.fastfood),
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
                      labelText: "Quantite Article",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer  la quantite a ajoute",hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:(value){
                      if(value!.isEmpty ){
                        return "Veuillez saisir une valeur";
                      }
                      return null;
                    }

                ),
                const SizedBox(
                  height:10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity,50),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState?.validate() == true) {

                      // on recupere les elements contenu dans dans les TextFormfield
                      var ValeurEntrerT= QuantiteArticleEntrer.value.text;

                      final database_article  = DatabaseArticle();

                      dynamic result =  database_article.updateQuantiteArticleEntrer(context,user.uid,user.codeArticle,ValeurEntrerT);
                      toggleView();
                      Navigator.pop(context,true);


                      if(result!=null){
                        Navigator.of(context).pop();
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


  }



  Future <void> DialogChoix(BuildContext context) async{
    showCupertinoDialog(
        barrierDismissible: true,//quitter le dialog en cliquant a cote
        context: context,
        builder: DialogChoixVue
    );
  }
  Future<void> dialogMore(BuildContext context) async {

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(children: [
          ElevatedButton(
              child: Text("Sortie d'article"),
              onPressed:(){DialogChoix(context);} ),
          RaisedButton(
              child: Text("entrer d'article"),
              onPressed:(){ModalUpdate(context);}),
          RaisedButton(
              child: Text("Modifier l'article"),
              onPressed:(){ModalUpdate(context);}),

        ],))).close;
  }
  Widget DialogChoixVue(BuildContext context)=>CupertinoAlertDialog(
    title: Text(
      "Action a effectue sur l'article",
      style: TextStyle(fontSize: 22),
    ),
    content:Padding(
      padding: EdgeInsets.only(top: 15),
    child: Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white70,
              onPrimary: Colors.white70,
              minimumSize: Size(double.infinity,55),
            ),
            child: Text("Sortie d'article",style: TextStyle(color:Colors.black87),),
            onPressed:(){
              Navigator.of(context).pop();
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
                            child:Text("Quantite a sortir au stock de l'article  " + user.name ,style: TextStyle(fontSize:18),),
                          ),
                          const SizedBox(
                            height:20,
                          ),
                          TextFormField(
                              controller:  QuantiteArticleEntrer,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                    child:   Icon(Icons.fastfood),
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
                                labelText: "Quantite Article",labelStyle: TextStyle(color: Colors.blueAccent),
                                hintText: "entrer  la quantite a sortir",hintStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator:(value){
                                if(value!.isEmpty ){
                                  return "Veuillez saisir une valeur";
                                }
                                return null;
                              }

                          ),
                          const SizedBox(
                            height:10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              onPrimary: Colors.white,
                              minimumSize: Size(double.infinity,50),
                            ),
                            onPressed: () async{
                              if (_formKey.currentState?.validate() == true) {

                                // on recupere les elements contenu dans dans les TextFormfield
                                var ValeurEntrerT= QuantiteArticleEntrer.value.text;

                                final database_article  = DatabaseArticle();

                                dynamic result =  database_article.updateQuantiteArticleSortie(context,user.uid,user.codeArticle,ValeurEntrerT);
                                toggleView();
                                Navigator.pop(context,true);


                                if(result!=null){
                                  Navigator.of(context).pop();
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


            } ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white70,
              onPrimary: Colors.white70,
              minimumSize: Size(double.infinity,55),
            ),
            child: Text("entrer d'article",style: TextStyle(color:Colors.black87)),
            onPressed:(){
              Navigator.of(context).pop();
              ModalEntrer(context);
            }),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white70,
              onPrimary: Colors.white70,
              minimumSize: Size(double.infinity,55),
            ),
            child: Text("Modifier l'article",style: TextStyle(color:Colors.black87)),
            onPressed:(){
              Navigator.of(context).pop();
              ModalUpdate(context);
            }),

      ],),),
    actions: [
      CupertinoDialogAction(
        child: Text('Sortir'),
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
    final  description = TextEditingController();
    final  categorie = TextEditingController();
    final  codeArtcile = TextEditingController();
    final  codeFournisseur = TextEditingController();
    final _formKey = GlobalKey<FormState>();


    Future showToast(String message) async{
      //   await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);

    }

    void toggleView() {

        _formKey.currentState?.reset();// on vide le contenu dans le formulaire
        name.text = '';
        description.text = '';
        categorie.text = '';
        codeArtcile.text = '';
        codeFournisseur.text = '';
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
                      child:Text("Modifier l'article  " + user.name ,style: TextStyle(fontSize: 25),),
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.fastfood),
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
                          labelText: "Nom Article",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer un nouveau nom d'article",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty && value.length<4){
                            return "Veuillez saisir un nom article(quatre lettres minimun)";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                        controller: categorie,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.cases),
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
                          labelText: "Nom Caegories",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer  nouvelle categorie",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty){
                            return "Veuillez saisir une categorie";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                        controller:description,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              child:   Icon(Icons.description),
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
                          labelText: "Description",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "entrer  une nouvelle description",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty){
                            return 'Veuillez saisir une description';
                          }
                          return null;
                        }

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(

                      padding:EdgeInsets.all(0),
                      child:  Container(
                        height:45,
                        width: 600,
                        padding: EdgeInsets.only(left:27),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:Row(
                          children: [
                          Text("Code Article :     ",style: TextStyle(fontSize: 16),),
                          Text(user.codeArticle,style: TextStyle(fontSize: 14),)
                        ],),
                      ),),
                    const SizedBox(height: 15),
                    Padding(

                      padding:EdgeInsets.all(4),
                      child:  Container(
                        height: 45,
                        width: 600,
                        padding: EdgeInsets.only(left: 27),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text("Code Fournisseur :     ",style: TextStyle(fontSize: 16),),
                            Text(user.codeFournisseurs,style: TextStyle(fontSize: 14),)
                          ],),
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
                          var categorieT=categorie.value.text;
                          var descriptionT=description.value.text;



                          final database_article  = DatabaseArticle();

                          dynamic result =  database_article.updateArticle(context,user.uid,nameT,categorieT, descriptionT);
                          toggleView();
                          Navigator.pop(context,true);


                          if(result!=null){
                            Navigator.of(context).pop();
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


    }





    Future<void> dialogsuppresion(BuildContext context) async {

      await  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("l'article "+user.name +" supprimé"))).closed;
    }
    Widget createDialog(BuildContext context)=>CupertinoAlertDialog(
      title: Text(
        "Supprimer l'article",
        style: TextStyle(fontSize: 22),
      ),
      content:Text(
        'voulez vous vraiment supprimer cet Article?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('oui'),
          onPressed: (){
            final database_article  = DatabaseArticle();
            database_article.deleteUser(user.uid);
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
    Future <void> suppressionArticle(BuildContext context) async{
      showCupertinoDialog(
          barrierDismissible: true,//quitter le dialog en cliquant a cote
          context: context,
          builder: createDialog
      );
    }


    return  Slidable(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Card(
          //elevation: 8.0,
          //  margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
          child: ListTile(
            title: Text(user.name),
            subtitle:  Text(' ${user.quantite}'),
          ),
        ),
      ),
      key: const ValueKey(0),

      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed:suppressionArticle,
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
            onPressed:DialogChoix,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.more_horiz,
            label: 'More',
          ),
        ],
      ),
    );


  }

}


