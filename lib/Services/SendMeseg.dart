//
//
//
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Ascii.dart';
// import 'SDSservices.dart';
//
// final _firestore = Firestore.instance;
//
//
// sendTextMessage(String recName, String senderName, String message, String type, String msgDocId, bool byBot) async {
//   SDESServices services = SDESServices();
//   if (!byBot) {
//     Random rand = Random();
//     int j = rand.nextInt(message.length);
//     String key = message.codeUnitAt(j).toRadixString(2);
//     key = "0" + key + "10";
//     print("MY KEY:- $key");
//     List<String> keyValues = services.keyGeneration(key);
//
//     ///ecryption
//     List<String> CT = services.sDesEncryption(message, keyValues[0], keyValues[1]);
//     print(CT);
//     List<int> list = [];
//     String res = "";
//     CT.forEach((element) {
//       // list.add(int.parse(element, radix: 2));
//       res = res + myAscii[element];
//     });
//     //print(list);
//     //print(utf8.decode(list, allowMalformed: true));
//     print(res);
//     message = res;
//   }
//   await _firestore.collection('messages').doc(msgDocId).collection('conversation').doc().set({
//     'text': message,
//     'senderName': senderName,
//     'receiverName': recName,
//     'dateTime': DateTime.now().toString(),
//     'type': type
//   });
// }
