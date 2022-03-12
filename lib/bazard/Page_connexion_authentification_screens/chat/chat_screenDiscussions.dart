import 'package:flutter/material.dart';

import 'package:flutter_firebase/bazard/models/chat_paramsDiscussions.dart';



import '../../models/chat_params.dart';

import 'chat.dart';
import 'chatDiscussions.dart';
// ici l'orsque l'on clique sur un element de la liste on recuperer nom et on affiche dans l'appbar
class ChatScreenDiscussions extends StatelessWidget {
  final ChatParamsDiscussions chatParamsDiscussions;

  const ChatScreenDiscussions({Key? key, required this.chatParamsDiscussions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context){
              return  Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 200,
                        child: Container(
                          width:50,
                          child:IconButton(
                            icon:Icon(Icons.keyboard_backspace,size:30,color: Colors.white,),
                            onPressed: () {

                              Navigator.of(context).pop(context);
                            },

                          ),
                        )
                    ),
                  ],
                ),);
            },
          ),
          title: Text('Tu ecris avec  ' + chatParamsDiscussions.peer.name)
      ),
      body: ChatDiscussions(chatParamsDiscussions: chatParamsDiscussions),
    );
  }
}
