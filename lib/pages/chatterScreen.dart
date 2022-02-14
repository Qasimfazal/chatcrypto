import 'dart:math';

import 'package:chatcrypto/Services/Ascii.dart';
import 'package:chatcrypto/Services/SDSservices.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

final _firestore = Firestore.instance;
String username = 'User';
String email = 'user@example.com';

FirebaseUser loggedInUser;

class ChatterScreen extends StatefulWidget {
  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  final chatMsgTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;
  //String encymessage;
  sendTextMessage(String messageText) async {
    SDESServices services = SDESServices();

      Random rand = Random();
      int j = rand.nextInt(messageText.length);
      String key = messageText.codeUnitAt(j).toRadixString(2);
      key = "0" + key + "10";
      print("MY KEY:- $key");
      List<String> keyValues = services.keyGeneration(key);

      ///ecryption
      List<String> CT = services.sDesEncryption(messageText, keyValues[0], keyValues[1]);
      print(CT);
      List<int> list = [];
      String res = "";
      CT.forEach((element) {
        // list.add(int.parse(element, radix: 2));
        res = res + myAscii[element];
      });
      //print(list);
      //print(utf8.decode(list, allowMalformed: true));
      print(res);
    messageText = res;

    await _firestore.collection('messages').add({
      'sender': username,
      'text': messageText,
      'timestamp':DateTime.now().millisecondsSinceEpoch,
      'senderemail': email,
      'keyValues0' : keyValues[0],
      'keyValues1' : keyValues[1],

    });

    }
// Decrypyion(Receivedmsg){
//   SDESServices services = SDESServices();
//   List<String> PT = services.sDesDecryption(Receivedmsg, keyValues[0], keyValues[1]);
//   print(PT);
//   List<int> list2 = [];
//   String res2 = "";
//   PT.forEach((element) {
//     // list.add(int.parse(element, radix: 2));
//     res2 = res2 + myAscii[element];
//   });
//   //print(list);
//   //print(utf8.decode(list, allowMalformed: true));
//   print(res2);
// }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getMessages();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          username = loggedInUser.displayName;
          email = loggedInUser.email;
        });
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'Something Went Wrong',
          description: e.toString(),
          gravity: EdgeAlert.BOTTOM,
          icon: Icons.error,
          backgroundColor: Colors.deepPurple[900]);
    }
  }
  // void getMessages()async{
  //   final messages=await _firestore.collection('messages').getDocuments();
  //   for(var message in messages.documents){
  //     print(message.data);
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     snapshot.documents;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(25, 10),
          child: Container(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.blue[100],
            ),
            decoration: BoxDecoration(
                // color: Colors.blue,

                // borderRadius: BorderRadius.circular(20)
                ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white10,
        // leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CircleAvatar(backgroundImage: NetworkImage('https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'),),
        // ),
        title: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CryptoChat',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),

              ],
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple[900],
              ),
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png"),
              ),
              onDetailsPressed: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("Sign out of this account"),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatStream(),
          Container(
            padding: EdgeInsets.symmetric(vertical:10,horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation:5,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,top:2,bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText= value;
                        },
                        controller: chatMsgTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  shape: CircleBorder(),
                  color: Colors.blue,
                  onPressed: () async {
                    sendTextMessage(chatMsgTextController.text);
                    chatMsgTextController.clear();

                    // await sendTextMessage(messageText);
                    // await _firestore.collection('messages').add({
                    //   'sender': username,
                    //   'text': messageText,
                    //   'timestamp':DateTime.now().millisecondsSinceEpoch,
                    //   'senderemail': email
                    // });
                  },
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.send,color: Colors.white,),
                  )
                  // Text(
                  //   'Send',
                  //   style: kSendButtonTextStyle,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatStream extends StatelessWidget {
  @override
  SDESServices services = SDESServices();
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.documents.reversed;


          List<MessageBubble> messageWidgets = [];


          for (var message in messages) {
            final msgText = message.data['text'];
            final msgSender = message.data['sender'];
             final key1 = message.data['keyValues0'];
             final key2 = message.data['keyValues1'];
             final msgSenderEmail = message.data['senderemail'];
             final currentUser = loggedInUser.displayName;
            List<String> PT = services.sDesDecryption(msgText, key1, key2);
            print(PT);
            List<int> list2 = [];
            String res2 = "";
            PT.forEach((element) {
              // list.add(int.parse(element, radix: 2));
              res2 = res2 + myAscii[element];
            });
            //print(list);
            //print(utf8.decode(list, allowMalformed: true));
            print(res2);
             print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble = MessageBubble(
                msgText: res2??''.toString(),
                msgSender: msgSender,
                user: currentUser == msgSender);
            messageWidgets.add(msgBubble);

          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets??'',
            ),
          );
        } else {
          return Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.deepPurple),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
 var msgText;
 var  msgSender;
  final bool user;
  MessageBubble({this.msgText, this.msgSender, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(0) : Radius.circular(50),
            ),
            color: user ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}