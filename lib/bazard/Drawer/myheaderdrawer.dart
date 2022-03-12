

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget{

  _MyHeaderDrawerState createState()=> _MyHeaderDrawerState();

}

class _MyHeaderDrawerState extends State<MyHeaderDrawer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: 150,

      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/1.jpg')
              )
            ),
          ),
          Text("heriol Valdo",style: TextStyle(fontSize: 20,color: Colors.white),),
          Text("devflutter.info",style: TextStyle(fontSize: 14,color: Colors.grey[200]),)
        ],
      ),
    );
  }
}