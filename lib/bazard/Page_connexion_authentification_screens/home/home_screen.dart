import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/bazard/Page_connexion_authentification_screens/home/user_list.dart';


import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:enume/enume.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:enum_object/enum_object.dart';


import '../../../gestion/Database_service/authentication.dart';
import '../../Database_services/database.dart';
import '../../Database_services/notification_service.dart';
import '../../Drawer/contacts.dart';
import '../../Drawer/dashboard.dart';
import '../../Drawer/event.dart';
import '../../Drawer/myheaderdrawer.dart';
import '../../Drawer/notes.dart';
import '../../Drawer/notifications.dart';
import '../../Drawer/privacy_policy.dart';
import '../../Drawer/send_feedback.dart';
import '../../Drawer/settings.dart';
import '../../../gestion/loading_circular/loading.dart';
import '../../models/user.dart';




class HomeScreen extends StatefulWidget {

  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{
  String name="";
  final search = TextEditingController();

  final AuthenticationService _auth = AuthenticationService();



//element du navigationbutton
  int _currentIndex=0;
  final tabs=[
    Center(child: Text("home"),),
    Center(child: Text("search"),),
    Center(child: Text("camera"),),
    Center(child: Text("person"),),
  ];

  var currentPage = DrawerSections.dashboard;

@override
  Widget build(BuildContext context) {
  //element du drawer

  var container;
  if(currentPage==DrawerSections.dashboard){
    container=DashboardPage();
  }else if(currentPage==DrawerSections.contacts){
    container=ContactsPage();
  }else if(currentPage==DrawerSections.event){
    container=EventPage();
  }else if(currentPage==DrawerSections.notes){
    container=NotesPage();
  }else if(currentPage==DrawerSections.settings){
    container=SettingsPage();
  }else if(currentPage==DrawerSections.notifications){
    container=NotificationsPage();
  }else if(currentPage==DrawerSections.privacy_policy){
    container=PrivacyPolicyPage();
  }else if(currentPage==DrawerSections.send_feedback){
    container=SendFeedbackPage();
  }

    NotificationService.initialize();
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    Future showToast(String message) async{
  //   await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);

    }




  Future<void> dialogsuppresion(BuildContext context) async {

    await  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" element supprimé"))).closed;
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
    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          spacing: 12,
          closeManually: false,
          onClose: ()=>showToast("fermer"),
          onOpen: ()=>showToast("ouvert"),
          spaceBetweenChildren: 12,
          icon: Icons.share,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(

             backgroundColor: Colors.green,
              child: Icon(FontAwesomeIcons.voicemail),
                onTap:()=> showToast('mail'),
                label: "mail"
            ),
            SpeedDialChild(
                onTap:()=>showToast("copy"),
                child: Icon(Icons.copy),
                label: "copy"
            ),
            SpeedDialChild(
                onTap:()=>showToast("facebook"),
                child: Icon(FontAwesomeIcons.facebook),
                label: "facebook"
            ),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: Card(
            child: TextField(
              controller: search,
              // creation de la bar de recherche
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: (){
                    search.clear;

                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));


                  },
                  icon: Icon(Icons.clear),
                   ),
                hintText: "search..."),

            //specifier le typr de saisie
           /* keyboardType:TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ],*/
            onChanged: (val){
              setState(() {
                name=val;
              });
            },
            ),
          ),
          actions: <Widget>[
            StreamBuilder<AppUserData>(
              stream: database.user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AppUserData? userData = snapshot.data;
                  if (userData == null) return Loading();
                  return TextButton.icon(
                    icon: Icon(
                      Icons.wine_bar,
                      color: Colors.white,
                    ),
                    label: Text('drink', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                     // await database.saveUser(userData.name,userData.email);
                    },
                  );
                } else {
                  return Loading();
                }
              },
            ),
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('logout', style: TextStyle(color: Colors.white)),
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
        )*//*tabs[_currentIndex]*//*container*/UserList(),
        drawer: Drawer(

          elevation: 8.0,
          child: SingleChildScrollView(

            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
         // backgroundColor: Colors.orange,
          iconSize: 30,
          selectedFontSize: 10,
          unselectedFontSize: 15,
          items: [
            BottomNavigationBarItem(
              backgroundColor:Colors.blue,
              label:"home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              backgroundColor:Colors.greenAccent,
              label:"search",
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              backgroundColor:Colors.red,
              label:"camera",
              icon: Icon(Icons.camera),
            ),
            BottomNavigationBarItem(
              backgroundColor:Colors.orange,
              label:"person",
              icon: Icon(Icons.person),
            ),
          ],
          onTap: (index){
           setState(() {
             _currentIndex=index;
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
          if(id==1){
            currentPage=DrawerSections.dashboard;
          }else if(id==2){
            currentPage=DrawerSections.contacts;
          }else if(id==3){
            currentPage=DrawerSections.event;
          }else if(id==4){
            currentPage=DrawerSections.notes;
          }else if(id==5){
            currentPage=DrawerSections.settings;
          }else if(id==6){
            currentPage=DrawerSections.notifications;
          }else if(id==7){
            currentPage=DrawerSections.privacy_policy;
          }else if(id==8){
            currentPage=DrawerSections.send_feedback;
          }
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
  Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1,"Dashboard",Icons.dashboard_outlined,currentPage==DrawerSections.dashboard?true:false),
          menuItem(2,"Contacts",Icons.people_alt_outlined,currentPage==DrawerSections.contacts?true:false),
          Divider(),
          menuItem(3,"Events",Icons.event,currentPage==DrawerSections.event?true:false),
          menuItem(4,"Notes",Icons.notes,currentPage==DrawerSections.notes?true:false),
          Divider(),
          menuItem(5,"Settings",Icons.settings_outlined,currentPage==DrawerSections.settings?true:false),
          menuItem(6,"Notifications",Icons.notifications_outlined,currentPage==DrawerSections.notifications?true:false),
          Divider(),
          menuItem(7,"Privacy policy",Icons.privacy_tip_outlined,currentPage==DrawerSections.privacy_policy?true:false),
          menuItem(8,"Send feedback",Icons.feedback_outlined,currentPage==DrawerSections.send_feedback?true:false),
        ],
      ),
    );
  }

}
//element du drawer hors classe
enum DrawerSections{
  dashboard,
  contacts,
  event,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}




/*Container(

                                            padding: EdgeInsets.only(top: 16),
                                            child: Column(
                                            children: [
                                              ListTile(
                                                onTap:(){
                                                 database.deleteUser();
                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                     SnackBar(content: Text("${date['name']} supprimé"))).closed;
                                                },
                                              title: Text(date['name'],style:
                                                TextStyle(fontSize: 20),),
                                              ),
                                              Divider(
                                                thickness: 2,
                                              )

                                            ],
                                            ),
                                            );*/