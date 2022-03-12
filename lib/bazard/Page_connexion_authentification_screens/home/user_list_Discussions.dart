import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/bazard/models/chat_paramsDiscussions.dart';
import 'package:flutter_firebase/bazard/models/user.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../chat/chat_screenDiscussions.dart';

class UserListDiscuusions extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserListDiscuusions> {
    @override
  Widget build(BuildContext context) {
      final users = Provider.of<List<AppUserDiscussions>>(context);
      return ListView.builder(
          itemCount:users.length,
          itemBuilder: (context, index) {
            return UserTile(users[index]);
          }
      );
  }
}


class UserTile extends StatelessWidget {
  final AppUserDiscussions user;

  UserTile(this.user);


  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenDiscussions( chatParamsDiscussions:ChatParamsDiscussions(currentUser.uid, user))));
             },

      child: Padding(
          padding: const EdgeInsets.only(top:0.0),
        child: Card(
          shadowColor: Colors.red,
         // color: Colors.red,
          elevation: 0.0,
          margin: EdgeInsets.only(top:1.0, bottom: 0.0, left:1.0, right:1.0),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(
              children: [
                Padding(
                  child: ClipOval(

                    child:  Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: AssetImage('images/1.jpg'),
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        child: InkWell(onTap:(){} ,),
                      ),
                    ),
                  ),
                    padding:EdgeInsets.all(5.0),
                ),
                /*Container(
                  margin: EdgeInsets.only(left:10,bottom:15,top: 10),
                  //height:0,
                  child: Image.asset('images/1.jpg',height: 70,fit: BoxFit.cover,width:60,),
                  decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/1.jpg')
                      )
                  ),
                ),*/

                SizedBox(width: 0,),
                Container(child:Text(user.name,style: TextStyle(fontSize:15),),)


              ],
            )
             // Text('Statut ${user.waterCounter} all users'),
            ],
          ),
        )
      )
    );
  }
}
