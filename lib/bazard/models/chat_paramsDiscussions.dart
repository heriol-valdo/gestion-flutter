
// fichier qui  gerer le nom des utlisateur et leurs messages
import 'package:flutter_firebase/bazard/models/user.dart';

class ChatParamsDiscussions{
  final String userUid;
  final AppUserDiscussions peer;

  ChatParamsDiscussions(this.userUid, this.peer);

  String getChatGroupId() {
    if (userUid.hashCode <= peer.uid.hashCode) {
      return '$userUid-${peer.uid}';
    } else {
      return '${peer.uid}-$userUid';
    }
  }
}