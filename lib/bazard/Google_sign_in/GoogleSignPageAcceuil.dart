import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/user.dart';
import '../View_page/Home_page/Acceuil.dart';
import 'LoggedInWidget.dart';
import 'SignUpWidget.dart';

class GoogleSignPageAcceuil extends StatelessWidget {

  static final String title = 'Page_connexion';
  @override
  Widget build(BuildContext context) {

  return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
      home: HomePage(),


    );
  }
}

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    return Scaffold(
      body: StreamBuilder(

        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(user != null){
            return Acceuil();
          } else{
            return SignUpWidget();
          }

        },
      ),
    );
  }
}

