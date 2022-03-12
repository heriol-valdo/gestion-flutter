import 'package:flutter/material.dart';
import 'package:flutter_firebase/bazard/Google_sign_in/GoogleSignPageAcceuil.dart';

import 'package:flutter_firebase/bazard/models/user.dart';
import 'package:flutter_firebase/gestion/Page_acceuil/Home_Page.dart';
import 'package:flutter_firebase/gestion/Page_connexion/Authentification.dart';
import 'package:provider/provider.dart';

import '../Model/AppUserId.dart';





class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUserId?>(context);
    if (user == null) {
      return AuthenticatePage();
    } else {
      return HomePageAcceuil();
    }
  }
}
