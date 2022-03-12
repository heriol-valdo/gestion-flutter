import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_firebase/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../models/user.dart';
import '../../Page_connexion_authentification_screens/chat/chat_screen.dart';

import '../../models/chat_params.dart';


import '../Home_page/Acceuil.dart';
import 'ModelUser.dart';
import 'ParamsUser.dart';


class ProfileUser extends StatefulWidget{
  final ParamsUser paramsUser;
  final AppUserData user;

  const ProfileUser({Key? key, required this.paramsUser, required this.user}) : super(key: key);
  _ProfileUser createState()=> _ProfileUser(paramsUser,user);
}


class _ProfileUser extends State<ProfileUser>{

 final ParamsUser paramsUser;
 final AppUserData user;
  _ProfileUser(this.paramsUser, this.user);

  @override
  Widget build(BuildContext context) {
    bool etatPhone=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatPhone=true;}else{etatPhone=false;}
    bool etatAdress=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatAdress=true;}else{etatAdress=false;}
    bool etatReligion=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatReligion=true;}else{etatReligion=false;}
    bool etatEtudes=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatEtudes=true;}else{etatEtudes=false;}
    bool etatTaille=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatTaille=true;}else{etatTaille=false;}
    bool etatStatut=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatStatut=true;}else{etatStatut=false;}
    bool etatAge=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatAge=true;}else{etatAge=false;}


    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    // TODO: implement build
   return Scaffold(

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.email,size: 20,color: Colors.white,),
       backgroundColor:Colors.blueAccent ,
       foregroundColor:Colors.blueAccent ,
       focusColor: Colors.blueAccent,
       focusElevation:2 ,
       onPressed:(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen( chatParams:ChatParams(currentUser.uid, user))));
       } ,
       elevation: 2,
       /*shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
       ),*/

     ),
     body:ListView(
       children: [
         Column(children: [
           SizedBox(height: 10,),
           // row du profile
           Row(
             crossAxisAlignment: CrossAxisAlignment.center,
               children:[
                 Container(
                   padding: EdgeInsets.only(right: 10.0),
                   child: IconButton(
                     iconSize: 25,
                     color: Colors.white,
                     icon: Icon(Icons.clear),
                     onPressed: (){
                       Navigator.of(context).pop(context);
                     },
                   ),
                 ),
                 Flexible(
                   child: Container(
                     child: Center(
                       child: Text("Profile",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                     ),
                   ),
                 ),
                 Container(
                   child:Padding(
                     padding: EdgeInsets.only(right:16),
                     child:Icon(Icons.wb_sunny,color: Colors.white),
                 )
                   )

               ] ),
           SizedBox(height: 30,),
           // padding image nom email
           Padding(
               padding:EdgeInsets.all(10.0),
             child: Column(
               children: [
                 Container(
                   margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                   decoration: BoxDecoration(
                       shape:BoxShape.circle,
                       image: DecorationImage(
                           image: AssetImage('images/1.jpg')
                       )
                   ),
                 ),
                 Container(
                   child: Text(paramsUser.modelUser.name,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                 ),
                 Container(
                   child: Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                 ),
               ],
             ),
           ),
           SizedBox(height: 20,),
         //padding du center
         Padding(
             padding:EdgeInsets.all(5),
           child: Expanded(
             child:Container(

                 padding: EdgeInsets.only(left: 16,right: 16),
                 decoration: BoxDecoration(
                   color: Colors.white12,
                   border: Border.all(color: Colors.grey,width: 1),
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
                             child: etatPhone?Text("+237.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):Text(paramsUser.modelUser.telephone,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                                 child: Text("Adresse"),
                               ),
                             ],
                           ),
                           Container(
                             child:etatAdress?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),): Text(paramsUser.modelUser.adresse,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                             child:etatReligion?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                             Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                                 child:
                                 Text("Etudes"),
                               ),
                             ],
                           ),
                           Container(
                             child:etatEtudes?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),): Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                             child:etatTaille?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                             Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                                 child:
                                 Text("Statut"),
                               ),
                             ],
                           ),
                           Container(
                             child:etatStatut?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),): Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                             child:etatAge?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                             Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
                             child:
                             Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                           )
                         ],
                       ),
                     ),
                   ),
                 ],
               )
             ),
           ),
         ),
         ],
         )

       ],
     ) ,
   );
  }
}