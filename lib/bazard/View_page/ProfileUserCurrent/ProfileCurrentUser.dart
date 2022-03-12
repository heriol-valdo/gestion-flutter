import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/bazard/models/chat_paramsDiscussions.dart';
import 'package:flutter_firebase/bazard/models/user.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Database_services/database.dart';






class ProfileCurrentUser extends StatefulWidget {
  _ProfileUserCurrent createState()=> _ProfileUserCurrent();
}
class _ProfileUserCurrent extends State<ProfileCurrentUser>{

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserProfile>>(context);

    return ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return lessProfileCurrrentUser(users[index]);
        }
    );

    // TODO: implement build

  }
}


class lessProfileCurrrentUser extends StatefulWidget {
  final  AppUserProfile appUserData;

  lessProfileCurrrentUser(this.appUserData);

  _lessProfileCurrrentUser createState()=>_lessProfileCurrrentUser(appUserData);
}
class _lessProfileCurrrentUser extends State<lessProfileCurrrentUser>{
  final  AppUserProfile appUserData;
  _lessProfileCurrrentUser(this.appUserData);

DatabaseProfile databaseProfile=DatabaseProfile();

  // element de modification de photo
  XFile? imageFile;

  _openCamera(BuildContext context) async{

    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile=picture as XFile?;

    });
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
   // Navigator.of(context).pop();
    this.setState(() {
      imageFile=picture as XFile?;
      String image=imageFile!.path;
      databaseProfile.savePhoto(image);
    });

  }


  Future<void> _showChoixDialog(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text("Make a choix"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(appUserData.photo.toString().isEmpty){
      return Material(
        color: Colors.transparent,
        child: Ink.image(

          image: AssetImage('images/1.jpg'),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap:(){
            showToast("message");
            // createDialog();
            _showChoixDialog;
          } ,),
        ),
      );
    } else{
      //var image = imageFile as ImagePicker;
      // return Image(image:image,width: 400,height: 200,);
      // return Image.file(File(imageFile!.path),width: 400,height: 400,);
      //  return Text("yes image selected");


      if(kIsWeb){
       // return Image.network(imageFile!.path,width: 128,height: 128,);
        String image=appUserData.photo;
         return Image.network(image,width: 128,height: 128,);
       // return Text(appUserData.photo.toString());
      }else{
       // return Text(appUserData.photo.toString());
        return Image.file(File(imageFile!.path),width:128,height: 128,);
      }


    }
  }



  String dropdownReligion="";
  int R=0;
  var DropdownMenutemReligion=[
    '','catholique','protestant','musulmans','autres'
  ];

 String dropdownEtudes="";
  int E=0;
  var DropdownMenutemEtudes=[
    '','< Bac','Bac','Bac+1','Bac+2','Licence/Bachelor','Bac+4','Master/ingenieur','Doctorat','Professeur'
  ];

  String dropdownTaille="";
  int T=0;
  var DropdownMenutemTaille=[
    '','91 cm','92 cm','93 cm','94 cm','95 cm','96 cm','97 cm','98 cm','99 cm','100 cm'
  ];

  String dropdownStatut="";
  int S=0;
  var DropdownMenutemStatur=[
    '','celibataire','Marier','En couple','veuf/veuve'
  ];

  String dropdowAge="";
  int A=0;
  var DropdownMenutemAge=[
   '', '18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35'
    ,'36','37','38','39','40','41','42','43','44','45','46','47','48','49','50 et plus'
  ];


      bool etatModifie=true;
      final _formKey = GlobalKey<FormState>();

  Future showToast(String message) async{
    //   await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);

  }
  void createDialog()async{
   await CupertinoAlertDialog(
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



  @override
  Widget build(BuildContext context) {

    // if de modification
    bool etatPhone=true;
    if(appUserData.telephone.toString().isEmpty){etatPhone=true;}else{etatPhone=false;}
    bool etatAdress=true;
    if(appUserData.adresse.toString().isEmpty){etatAdress=true;}else{etatAdress=false;}
    bool etatReligion=true;
    if(appUserData.religion.toString().isEmpty){etatReligion=true;}else{etatReligion=false;}
    bool etatEtudes=true;
    if(appUserData.etudes.toString().isEmpty){etatEtudes=true;}else{etatEtudes=false;}
    bool etatTaille=true;
    if(appUserData.taille.toString().isEmpty){etatTaille=true;}else{etatTaille=false;}
    bool etatStatut=true;
    if(appUserData.statut.toString().isEmpty){etatStatut=true;}else{etatStatut=false;}
    bool etatAge=true;
    if(appUserData.age.toString().isEmpty){etatAge=true;}else{etatAge=false;}

    // if de sauvegarder
    bool etatPhoneSauv=true;
    if(appUserData.telephone.toString().isEmpty){etatPhoneSauv=true;}else{etatPhoneSauv=false;}
    bool etatAdressSauv=true;
    if(appUserData.adresse.toString().isEmpty){etatAdressSauv=true;}else{etatAdressSauv=false;}
    bool etatReligionSauv=true;
    if(appUserData.religion.toString().isEmpty){etatReligionSauv=true;}else{etatReligionSauv=false;}
    bool etatEtudesSauv=true;
    if(appUserData.etudes.toString().isEmpty){etatEtudesSauv=true;}else{etatEtudesSauv=false;}
    bool etatTailleSauv=true;
    if(appUserData.taille.toString().isEmpty){etatTailleSauv=true;}else{etatTailleSauv=false;}
    bool etatStatutSauv=true;
    if(appUserData.statut.toString().isEmpty){etatStatutSauv=true;}else{etatStatutSauv=false;}
    bool etatAgeSauv=true;
    if(appUserData.age.toString().isEmpty){etatAgeSauv=true;}else{etatAgeSauv=false;}



    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return
    Form(
      key:_formKey,
      child:Column(children: [
        SizedBox(height: 10,),
        // padding image nom email
        Padding(
          padding:EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width:Get.size.width,
                margin: EdgeInsets.only(bottom: 10),
                //height: 70,
               /* decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/1.jpg')
                    )
                ),*/
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                   ClipOval(
                     child:_decideImageView()  /*Material(
                       color: Colors.transparent,
                       child: Ink.image(

                         image: Image.network(imageFile!.path,width: 400,height: 400,),
                         fit: BoxFit.cover,
                         width: 128,
                         height: 128,
                         child: InkWell(onTap:(){
                           showToast("message");
                          // createDialog();
                           _showChoixDialog;
                         } ,),
                       ),
                     )*/,),
                   Positioned(
                        bottom:5,
                        right:178,
                            child:Container(
                            decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                      color: Colors.lightBlue,
                      shape: BoxShape.circle,
                    ),

                    height: 30,
                    width: 30,
                    child: InkWell(
                    onTap: (){
                      _openGallery(context);
                      showToast("message");
                    createDialog();
                   // _showChoixDialog;
                    },
                    child: Icon(
                    Icons.edit,
                    size: 20,
                    ),),
                    )
                    )

                  ],
                ),
              ),
              Container(
                child: Text(appUserData.name,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
              ),
              Container(
                child: Text(appUserData.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        //padding du center
        Row(children:[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(""),
          ),
          Flexible(
            child: Container(
              child: Center(
                child: Text(""),
              ),
            ),
          ),
          Container(
            child: Padding(
              child: TextButton(
                child: Text(etatModifie?"Modifier":"Sauvegarder",style: TextStyle(color: Colors.blueAccent,fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w200),),
                onPressed: () {
                  setState(() {
                    if(etatModifie==true){
                      etatModifie=false;
                    }else if(etatModifie==false){
                      etatModifie=true;
                    }
                  });


                },

              ),
              padding: EdgeInsets.only(right:16),
            ),
          )

        ] ),
       // padding des elements
        Padding(
          padding:EdgeInsets.all(5),
          child:Container(
             // color: Colors.white12,
                padding: EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border.all(color: Colors.white12,width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.add_ic_call_rounded,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Telephone"),
                                ),
                              ],
                            ),
                            Container(
                              child:etatModifie ? etatPhone?Text("+237.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.telephone,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100)) :
                              TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                               keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: etatPhoneSauv?"Veuillez inserer un numero":appUserData.telephone
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.add_location,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Adresse"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatAdress?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.adresse,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: etatAdressSauv?"veuillez entrer une adresse":appUserData.adresse
                                ),)
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.book_outlined,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Religion"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatReligion?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.religion,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatReligionSauv?Text("selectionner une religion"):Text(appUserData.religion),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownReligion,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownReligion=newvalue!;
                                              showToast(newvalue);


                                              if(DropdownMenutemReligion[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemReligion.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.book,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Etudes"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie?etatEtudes?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.etudes,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatEtudesSauv?Text("selectionner un diplome"):Text(appUserData.etudes),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownEtudes,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownEtudes=newvalue!;

                                              if(DropdownMenutemEtudes[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemEtudes.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.merge_type,color: Colors.white),
                                ),
                                Container(
                                  child:Text("Taille"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatTaille?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.taille,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatTailleSauv?Text("selectionner une taille"):Text(appUserData.taille),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownTaille,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownTaille=newvalue!;

                                              if(DropdownMenutemTaille[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemTaille.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(FontAwesomeIcons.genderless,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Statut"),
                                ),
                              ],
                            ),
                            Container(
                              child:etatModifie? etatStatut?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.statut,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatStatutSauv?Text("selectionner un Statut"):Text(appUserData.statut),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownStatut,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownStatut=newvalue!;

                                              if(DropdownMenutemStatur[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemStatur.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(FontAwesomeIcons.oldRepublic,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Age"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatAge?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.age,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatAgeSauv?Text("selectionner un age"):Text(appUserData.age),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdowAge,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdowAge=newvalue!;

                                              if(DropdownMenutemAge[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemAge.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.wc_outlined,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Sexe"),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(appUserData.name,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(width: 35,),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          onPrimary: Colors.white,
                          minimumSize: Size(double.infinity,50),
                        ),
                        onLongPress: (){
                          showToast("heriol");
                        },
                        onPressed: (){
                          createDialog();

                        },
                        child: Text("Supprimer mon compte"),
                      ),
                    ),

                    SizedBox(width: 15,),



                  ],
                )
            ),

        ),
      ],
      ) ,
    );


  }
}


