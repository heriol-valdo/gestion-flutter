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
import 'package:flutter_firebase/gestion/Model/AppUserGestion.dart';
import 'package:flutter_firebase/gestion/Model/AppUserId.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class Drawer_name extends StatefulWidget {
  _ProfileUserCurrent createState()=> _ProfileUserCurrent();
}
class _ProfileUserCurrent extends State<Drawer_name>{

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserGestion>>(context);

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
  final  AppUserGestion appUserData;

  lessProfileCurrrentUser(this.appUserData);

  _lessProfileCurrrentUser createState()=>_lessProfileCurrrentUser(appUserData);
}
class _lessProfileCurrrentUser extends State<lessProfileCurrrentUser>{
  final  AppUserGestion appUserData;
  _lessProfileCurrrentUser(this.appUserData);



  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUserId?>(context);
    if (currentUser == null) throw Exception("current user not found");

    var text1;

    var text=Center(child: Container(
     color: Colors.black87,
     child: Text(appUserData.name.toString(),style: TextStyle(color: Colors.white,fontSize:15,)),
   ),);

    text1=text;

    return text1;


  }
}


