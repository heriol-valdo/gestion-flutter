import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_firebase/bazard/Database_services/database.dart';
import 'package:flutter_firebase/bazard/models/chat_params.dart';
import 'package:flutter_firebase/bazard/models/user.dart';
import 'package:flutter_firebase/gestion/Model/article_model.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../bazard/View_page/Profile/ParamsUser.dart';
import '../../bazard/View_page/Profile/PrafileUser.dart';

import '../Model/AppUserId.dart';



class InventairesList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<InventairesList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Article>>(context);

    return ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return UserTitle(users[index]);
        }
    );

  }
}



class UserTitle extends StatelessWidget {
  final Article user;
  UserTitle(this.user);

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<AppUserId?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return SingleChildScrollView(
         child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
                 child: Card(
              //elevation: 8.0,
              //  margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
                  child:  Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 25,right: 138),
                              child: Text(  user.name,style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),),
                            ),
                            Flexible(child:  Container(
                              padding: EdgeInsets.only(left:20,right:20),
                              child: Text(  user.Ssortie,style: TextStyle(fontSize: 15,fontStyle: FontStyle.normal),),
                            ),),
                            Flexible(child: Center(child: Container(
                              padding: EdgeInsets.only(),
                              child: Text(user.Sentrer,style: TextStyle(fontSize: 15,fontStyle: FontStyle.normal),),
                            ),),),
                            Flexible(child:   Container(
                            padding: EdgeInsets.only(left:25,right:0),
                            child: Text(user.quantite,style: TextStyle(fontSize: 15,fontStyle: FontStyle.normal),),
                          ),),
                          ],
                        ),

                      ),


                    ],
                  ),
              ),
              ),
              );


  }

}



