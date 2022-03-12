// ignore_for_file: equal_elements_in_set

import 'package:apk_admin/apk_admin.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../gestion/Database_service/authentication.dart';
import '../../Database_services/database.dart';
import '../../models/user.dart';
import '../../Page_connexion_authentification_screens/home/user_list.dart';
import '../../Page_connexion_authentification_screens/home/user_list_Discussions.dart';
import '../Drawer_name/Drawer_name.dart';
import '../ProfileUserCurrent/ProfileCurrentUser.dart';





class Acceuil extends StatefulWidget {
  _Acceuil createState()=> _Acceuil();
}

class _Acceuil extends State<Acceuil>{
  final AuthenticationService _auth = AuthenticationService();
  final currentUserEmailAndPassword=FirebaseAuth.instance.currentUser;

  
  bool etatAppbarAcceuil=true;
  bool etatDisPub=true;
  bool etatProfile=true;

  //element du navigationbutton
  int _currentIndex=0;




  @override
  Widget build(BuildContext context) {

    final username = Provider.of<AppUser?>(context);
    if (username == null) throw Exception("user not found");
    final database = DatabaseService(username.uid);

    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    DatabaseDiscussions databaseDiscussions= DatabaseDiscussions();

    final databaseProfile=DatabaseProfile();


    final tabs=[etatProfile? Container(
        child:Center(child:StreamProvider<List<AppUserData>>.value(
            initialData: [],
            value: database.users,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: UserList(),
            ),
          ) )) :
   Container(
        child:Center(child:StreamProvider<List<AppUserProfile>>.value(
          initialData: [],
          value: databaseProfile.users,
          child: Scaffold(
           // backgroundColor: Colors.white,
            body: ProfileCurrentUser(),
          ),
        ) )) ,

      etatProfile?   Center(child: Text("publications"),) : Container(
          child:Center(child:StreamProvider<List<AppUserProfile>>.value(
            initialData: [],
            value: databaseProfile.users,
            child: Scaffold(
              // backgroundColor: Colors.white,
              body: ProfileCurrentUser(),
            ),
          ) )),

      etatProfile?   Container(
            child:Center(child:StreamProvider<List<AppUserDiscussions>>.value(
              initialData: [],
              value: databaseDiscussions.usersDiscussions,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: UserListDiscuusions(),
              ),
            ) )) : Container(
          child:Center(child:StreamProvider<List<AppUserProfile>>.value(
            initialData: [],
            value: databaseProfile.users,
            child: Scaffold(
              // backgroundColor: Colors.white,
              body: ProfileCurrentUser(),
            ),
          ) )),
    ];



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return  Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Flexible(
                      flex: 200,
                      child: Container(
                    width:50,
                    child:IconButton(
                      icon:Icon(Icons.account_circle_rounded,size:30,),
                      onPressed: () {
                       // database.getDocument();
                        Scaffold.of(context).openDrawer();
                        },
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                      )
                  ),
                ],
              ),);
          },
        ),
        title: Row(
          children: [
            Flexible(
                child: Container(
               // width: 400,
                child:  Center(
                  child: etatAppbarAcceuil ?FaIcon(FontAwesomeIcons.mailBulk,size:32,color: Colors.blueAccent,):
                  etatDisPub?Text("Publications",style: TextStyle(fontSize:20,color: Colors.white))
                          :Text("Discussions",style: TextStyle(fontSize:20,color: Colors.white),),
                )

            )
            ),
            Container(
            //  width: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.settings,size: 30)),
            )
          ],
        ),
      ),
      body:Column(children: [
          Container(
           // height: 508,
            child: Flexible(child:tabs[_currentIndex]),),
          //Expanded(child: Divider(), )
        ]
      ),

      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        // pour que la couleur du bottomNavigation change en fonction de l'item
       // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.orange,
        iconSize:20,
       // selectedFontSize:0,
       // unselectedFontSize:0,
        items: [
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            tooltip:MaterialLocalizations.of(context).okButtonLabel,
            label:"",
           // label:"home",
            icon: Icon(Icons.water_damage),
          ),

          BottomNavigationBarItem(
            backgroundColor:Colors.greenAccent,
            label:"",
          //  label:"publication",
            icon: Icon(Icons.web_rounded),
          ),

          BottomNavigationBarItem(
            backgroundColor:Colors.orange,
            label:"",
          //  label:"message",
            icon: Icon(Icons.email),
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
            if(_currentIndex==2){
              etatProfile=true;
              etatAppbarAcceuil=false;
              etatDisPub=false;
            }else if(_currentIndex==0){
              etatProfile=true;
              etatAppbarAcceuil=true;
            }else if(_currentIndex==1){
              etatProfile=true;
              etatAppbarAcceuil=false;
              etatDisPub=true;
            }
          });


        },
      ),

     drawer:  Drawer(
       backgroundColor: Colors.black87,
       elevation: 8.0,
       child: SingleChildScrollView(
         child: Container(
           color: Colors.black87,
           child: Column(
             children: [
               // container header
               Container(
                 color: Colors.black87,
                 width: double.infinity,
                 height: 180,
                 padding: EdgeInsets.only(top: 20.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    /* Container(
                       margin: EdgeInsets.only(bottom: 10),
                       height: 70,
                       decoration: BoxDecoration(
                           shape:BoxShape.circle,
                           image: DecorationImage(
                               image: AssetImage('images/1.jpg')
                           )
                       ),
                     ),*/
                     Container(
                       margin: EdgeInsets.only(bottom: 10),
                       child: ClipOval(

                         child:  Material(
                           color: Colors.transparent,
                           child: Ink.image(
                             image: AssetImage('images/1.jpg'),
                             fit: BoxFit.cover,
                             width: 100,
                             height: 100,
                             child: InkWell(onTap:(){} ,),
                           ),
                         ),
                       ),
                     ),

                     Flexible(
                       child:/*Container(
                           color: Colors.black87,
                         child:StreamProvider<List<AppUserData>>.value(
                         initialData: [],
                           value: database.userDrawer,
                           child: Scaffold(
                             body:StreamBuilder<AppUserData>(
                               stream: database.user,
                               builder:(context, snapshot) {
                                 if (snapshot.hasData) {
                                   AppUserData? userData = snapshot.data;
                                   if (userData == null) return Loading();
                                   return Container(color: Colors.black87,
                                       child:Center(child:Text(userData.name,style: TextStyle(fontSize:15,color: Colors.white),)));
                                 } else {
                                   return Loading();
                                 }
                               },


                           ),
                         ) )
                     )*/ StreamProvider<List<AppUserProfile>>.value(
                       initialData: [],
                       value: databaseProfile.users,
                       child:Center(child: Drawer_name(),)

                     )
                     ),
                    // Text("" ,style: TextStyle(fontSize:10,color: Colors.white),),
                     Text(currentUserEmailAndPassword!.email!,style: TextStyle(fontSize:14,color: Colors.grey[200]),)
                   ],
                 ),
               ),
               Divider(thickness: 2,),
               const SizedBox(
                 height: 20,
               ),

               // element de la liste
               InkWell(
                 splashColor: Colors.black87,
                 child:  Container(
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.account_circle_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("Profil",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   setState(() {
                     etatProfile=false;
                   });

                   Navigator.pop(context);
                 },
               ),
               const SizedBox(
                 height: 20,
               ),
               InkWell(
                 child:  Container(
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.add_location_alt_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("Mes publications",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               const SizedBox(
                 height: 20,
               ),
               InkWell(
                 child:  Container(
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.category_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("categories",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               const SizedBox(
                 height: 80,
               ),
               Divider(thickness: 2,
                 height: 20,),
               InkWell(
                 child:  Container(
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 20,),
                       Center(child:
                       Container(width:280,child: Text("Centre d'assistance",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               const SizedBox(
                 height: 20,
               ),
               InkWell(
                 child:  Container(
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.login_sharp,size:25,color: Colors.red,)),
                       Container(width:200,child: Text("se deconnecter",style: TextStyle(color: Colors.red,fontSize:20,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   _auth.signOut();
                 },
               ),

             ],
           ),
         ),
       ),

     ),
    );
  }
}


