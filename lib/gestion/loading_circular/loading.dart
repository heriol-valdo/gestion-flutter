import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// la page de loading l'orsqu'on execute la commande de connection ou dinsertion
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitRipple(
          color: Colors.blue,
          size: 40.0,
        ),
      ),
    );
  }
}
