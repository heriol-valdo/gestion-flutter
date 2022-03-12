import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/bazard/Page_connexion_authentification_screens/home/user_list.dart';
import 'package:flutter_firebase/gestion/Database_service/Database_user.dart';
import 'package:flutter_firebase/gestion/Database_service/database_article.dart';
import 'package:flutter_firebase/gestion/Database_service/database_fournisseurs.dart';
import 'package:flutter_firebase/gestion/Model/AppUserGestion.dart';
import 'package:flutter_firebase/gestion/Model/AppUserId.dart';
import 'package:flutter_firebase/gestion/Model/article_model.dart';
import 'package:flutter_firebase/gestion/Model/fournisseurs_model.dart';
import 'package:flutter_firebase/gestion/list_view/article_list.dart';
import 'package:flutter_firebase/gestion/list_view/fournisseurs_list.dart';
import 'package:flutter_firebase/gestion/list_view/inventaire_list.dart';


import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:enume/enume.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:enum_object/enum_object.dart';


import '../../bazard/View_page/Drawer_name/Drawer_name.dart';
import '../Database_service/authentication.dart';
import '../../bazard/Database_services/database.dart';
import '../../bazard/Database_services/notification_service.dart';
import '../../bazard/Drawer/contacts.dart';
import '../../bazard/Drawer/dashboard.dart';
import '../../bazard/Drawer/event.dart';
import '../../bazard/Drawer/myheaderdrawer.dart';
import '../../bazard/Drawer/notes.dart';
import '../../bazard/Drawer/notifications.dart';
import '../../bazard/Drawer/privacy_policy.dart';
import '../../bazard/Drawer/send_feedback.dart';
import '../../bazard/Drawer/settings.dart';
import '../loading_circular/loading.dart';
import '../../bazard/models/user.dart';




class HomePageAcceuil extends StatefulWidget {

  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomePageAcceuil>{
  String name="";
  final search = TextEditingController();

  final AuthenticationService _auth = AuthenticationService();

  final userUid=FirebaseAuth.instance.currentUser;

  int _currentIndex=0;
  bool etatText=true;
  bool etatTextPremier=true;

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    final user = Provider.of<AppUserId?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);
    final currentUser = Provider.of<AppUserId?>(context);
    if (currentUser == null) throw Exception("current user not found");


    Future<void> dialogsuppresion(BuildContext context) async {
      await  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" element supprimé"))).closed;
    }
    Future showToast(String message) async{
      //   await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);
    }
    //on peut aussi avoir CupertinoAlertDialog a la place d'alertDialog et aussi flatbuttom(tout les bouttons vers la gauche) a la place de CupertinoDialogAction(chacun separer)
    Widget createDialog(BuildContext context)=>CupertinoAlertDialog(
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
            database.deleteUser();
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

    );



    final  database_article= DatabaseArticle();
    final  database_fournisseurs= DatabaseFournisseurs();
    final  database_user= DatabaseUser(user.uid);


    final tabs=[
    Center(child:StreamProvider<List<Article>>.value(
      initialData: [],
      value: database_article.users,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ArticleList(),
      ),
    )),
      Center(child:StreamProvider<List<Fournisseurs>>.value(
        initialData: [],
        value: database_fournisseurs.users,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FournisseursList(),
        ),
      )),
      Center(child:StreamProvider<List<Article>>.value(
        initialData: [],
        value: database_article.users,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Container(
                  color: Colors.blueAccent,
                  height: 50,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 80),
                        child: Text("nom Article",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),),
                      ),
                      Flexible(child:   Container(
                        padding: EdgeInsets.only(left:10,right:20),
                        child: Text("Sortie",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),),
                      )),
                      Flexible(child:   Container(
                        padding: EdgeInsets.only(left:10,right:20),
                        child: Text("Entrer",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),),
                      ),),
                      Flexible(child:  Container(
                        padding: EdgeInsets.only(left:10,right:10),
                        child: Text("Solde",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),),
                      ),)
                    ],
                  ),

                ),


              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: InventairesList(),
        ),
      )),
    ];



    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title:  Container(
              color: Colors.blueGrey,
              child:Center(
                child: Text(etatTextPremier ? etatText? "Articles" : "Fournisseurs" : "Inventaires" ,style:TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w200),),)),

          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('Se déconnecter', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: /*StreamBuilder<QuerySnapshot>(
          stream: (name !="" && name!= null )?
          FirebaseFirestore.instance.collection('users')
              .where('name', isGreaterThanOrEqualTo: name)
              .where('name', isLessThan: name +'z')
       .snapshots():
          FirebaseFirestore.instance.collection('users').snapshots(),builder:
        (context,snapshot){
            return(snapshot.connectionState == ConnectionState.waiting)?Center(
              child: CircularProgressIndicator()):
                ListView.builder(
                    itemCount:snapshot.data?.docs.length,
                    itemBuilder: (context, index){
                      DocumentSnapshot date =snapshot.data!.docs[index];

                      return Slidable(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                          child: Card(
                            //elevation: 8.0,
                          //  margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
                            child: ListTile(
                              title: Text(date['name']+"  "+date['age']),
                              subtitle: Text('Drink ${date['waterCount']} water of glass'),
                            ),
                          ),
                        ),
                          key: const ValueKey(0),

                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        dismissible:  DismissiblePane(
                          key: Key(date['name']),
                          onDismissed: (){
                            setState(() {
                              showCupertinoDialog(
                                  barrierDismissible: true,//quitter le dialog en cliquant a cote
                                  context: context,
                                  builder: createDialog
                              );
                              //   database.deleteUser();
                            });
                          //  ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(content: Text("${date['name']} supprimé")));
                          },

                        //  background: Container(color: Colors.blueGrey),
                        //  child: Container(),

                        ),
                        children: [
                          SlidableAction(
                            onPressed:createDialog,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                           onPressed: dialogsuppresion,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.more_horiz,
                            label: 'more',
                          ),
                      ],


                      ),
                        endActionPane: const ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 2,
                              onPressed: null,
                              backgroundColor: Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.archive,
                              label: 'Archive',
                            ),
                            SlidableAction(
                              onPressed: null,
                              backgroundColor: Color(0xFF0392CF),
                              foregroundColor: Colors.white,
                              icon: Icons.save,
                              label: 'Save',
                            ),
                          ],
                        ),
                      );
                      },
                );
        },
        )*/tabs[_currentIndex]/*container*//*UserList()*/ ,
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
                          child:StreamProvider<List<AppUserGestion>>.value(
                              initialData: [],
                              value: database_user.users,
                              child:Center(child: Drawer_name(),)

                          )
                      ),
                      // Text("" ,style: TextStyle(fontSize:10,color: Colors.white),),
                      Text(userUid!.email!,style: TextStyle(fontSize:14,color: Colors.grey[200]),)
                    ],
                  ),
                ),
                Divider(thickness: 2,),
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
        bottomNavigationBar: SingleChildScrollView(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.orange,
            iconSize: 30,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            items: [
              BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                label:"Articles",
                icon: Icon(Icons.no_food_rounded),
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                label:"Fournisseurs",
                icon: Icon(Icons.person_add_alt_1_rounded),
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                label:"Inventaires",
                icon: Icon(Icons.pending_actions_rounded),
              ),

            ],
            onTap: (index){
              setState(() {
                _currentIndex=index;
                if(_currentIndex==0){etatTextPremier=true; etatText=true;}
                else if(_currentIndex==1){etatTextPremier=true;etatText=false;}
                else if(_currentIndex==2){etatTextPremier=false;}
              });
            },
          ),
        ),
      );

  }
  //element du drawer

  Widget menuItem(int id,String title,IconData icon,bool selected){

    return Material(

      color: selected ? Colors.grey[200] : Colors.transparent,
      child: InkWell(

        onTap: (){
          Navigator.pop(context);

        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(child: Icon(icon,size: 20,color: Colors.black,)),
              Expanded(flex:1,child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16),)),
            ],
          ),
        ),
      ),
    );
  }


}



