import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_firebase/bazard/Database_services/database.dart';
import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/bazard/models/user.dart';
import 'package:flutter_firebase/gestion/Model/AppUserGestion.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/AppUserId.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserGestion>>(context);

    return ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return UserTile(users[index]);
        }
    );
  }
}


class UserTile extends StatelessWidget {
  final AppUserGestion user;
  UserTile(this.user);


  Future<void> dialogsuppresion(BuildContext context) async {

    await  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" element supprimé"))).closed;
  }
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
          // database.deleteUser();
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


  @override
  Widget build(BuildContext context) {
    final database = DatabaseService(user.uid);
    final currentUser = Provider.of<AppUserId?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return GestureDetector(

        onTap: (){
          if(currentUser.uid==user.uid)return;
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen( chatParams:ChatParams(currentUser.uid, user))));
         // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser(paramsUser: ParamsUser(currentUser.uid,user),user: user,)));
          // await database.deleteUser();
        },

        child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child:Card(
              shadowColor: Colors.red,
              // color: Colors.red,
              elevation: 1.0,
              margin: EdgeInsets.only(top:5.0, bottom: 5.0, left:10.0, right:8.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom:15,top: 10),
                    height: 90,
                    decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/1.jpg')
                        )
                    ),
                  ),
                  Text(user.name),
                  Text('Statut ${user.name} all users'),
                ],
              ),
            )

        )
    );


  }

}


/*Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.email,size: 20,color: Colors.white,),
          backgroundColor:Colors.blueAccent ,
          foregroundColor:Colors.blueAccent ,
          focusColor: Colors.blueAccent,
          focusElevation:2 ,
          onPressed:(){

          } ,
          elevation: 2,
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
       ),
),
   body: Slidable(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Card(
              //elevation: 8.0,
              //  margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
              child: ListTile(
                title: Text(user.name),
                subtitle:  Text('Statut ${user.name} all users'),
              ),
            ),
          ),
          key: const ValueKey(0),

          startActionPane: ActionPane(
            motion: const StretchMotion(),
            dismissible:  DismissiblePane(
              key: Key(user.name),
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
        ) ,
      );*/
/*  StreamBuilder<QuerySnapshot>(
          stream: (name !="" && name!= null)?
          FirebaseFirestore.instance.collection('users')
              .where('name', isGreaterThanOrEqualTo: name)
              .where('name', isLessThan: name +'z')
       .snapshots():
          FirebaseFirestore.instance.collection('users').snapshots(),builder:
        (context,snapshot){
            return(snapshot.connectionState == ConnectionState.waiting)?Center(
              child: CircularProgressIndicator()):
                ListView.builder(
                    itemCount:snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      DocumentSnapshot date =snapshot.data!.docs[index];

                      return Container(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                      children: [
                        ListTile(
                          onTap:(){
                            database.deleteUser();
                          },
                        title: Text(date['name'],style:
                          TextStyle(fontSize: 20),),
                        ),
                        Divider(
                          thickness: 2,
                        )

                      ],
                      ),
                      );
                    },
                );
        },
        ),*/
/*
     pour supprimer d'un seul geste
     return Dismissible(key: Key(recipe.title),
                    onDismissed: (direction){
                      setState(() {
                        RecipeDataBase.instance.deleteRecipe(recipe.title);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${recipe.title} supprimé")));
                    },
                    background: Container(color: Colors.red),
                    child: RecipeItemWidget(recipe: recipe));




     onTap: (){// pou quitter de cette passe et aller a une page de chat
        if (currentUser.uid == user.uid) return;
        Navigator.pushNamed(
          context,

          '/chat',
          arguments: ChatParams(currentUser.uid, user),
        );
      },*/