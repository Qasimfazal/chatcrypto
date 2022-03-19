import 'dart:math';

import 'package:chatcrypto/Result.dart';
import 'package:chatcrypto/Services/COnverter.dart';
import 'package:chatcrypto/Services/CeaserCipher.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

final _firestore = Firestore.instance;
String username = 'User';
String email = 'user@example.com';
String messageText;
String UUID;
FirebaseUser loggedInUser;

class ChatterScreen extends StatefulWidget {
  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

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
  int NewMsgKey;
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
            ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white10,
        title: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Chatter',
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
                          messageText = value;
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
                    onPressed: () async{
                      // myUsername;
                      // myEmail;
                      myKu;
                      int u = username.length;
                     await Ceaser.process(false, myKu, u);
                       print(ResultD2);
                         //
                          int a = int.parse(ResultD2);
                         // int b = messageText.length;
                         // int temp = a + b;
                         //  NewMsgKey = temp*6;
                         // if(NewMsgKey >= 26){
                         //    NewMsgKey = NewMsgKey%26;
                         // }
                        await Ceaser.process(true, messageText, a);
                        ResultD2;
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final FirebaseUser user = await auth.currentUser();
                      final uid = user.uid;
                      chatMsgTextController.clear();
                        await _firestore.collection('messages').add({
                        'sender': username,
                        'UserID': uid,
                        'msg': ResultD2,
                        'timestamp':DateTime.now().millisecondsSinceEpoch,
                        'senderemail': email,
                      });
                      ResultD2 ='';
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.send,color: Colors.white,),
                    )
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
  String myUsername_Dec = '';
  String myEmail_Dec = '';
  String myKu2_Dec = '';
  String UID_Dec ;
  GetRing_Dec(String Uid_Dec) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.currentUser;
    Firestore.instance.collectionGroup("Peoples").reference().document("Users")
        .collection(Uid_Dec)
        .snapshots()
        .listen((userData) {
      myUsername_Dec = userData.documents[0]['Name'];
      myEmail_Dec = userData.documents[0]['email'];
      myKu2_Dec = userData.documents[0]['Ku'];
    });
  }

  Widget build(BuildContext context) {
    int D_NewMsgKey;
    bool load ;
    return  StreamBuilder (
      stream:  _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final Uid = message.data['UserID'];
            myUsername_Dec;
            myEmail_Dec;
            myKu2_Dec;
            GetRing_Dec(Uid);


            final msgSender = message.data['sender'];
            final msg = message.data['msg'];
              myUsername_Dec;
              myEmail_Dec;
              myKu2_Dec;
              int u = myUsername_Dec.length;
              Ceaser.processDecryptFinal(false, myKu2_Dec, u);
              print(ResultDecryptFinal);
              int a = int.parse(ResultDecryptFinal);
            // int aa = a;
            // int b = msg.length;
            // int temp = aa + b;
            // int tmepResult = temp*6;
            //  D_NewMsgKey = tmepResult.toInt();
            // if(D_NewMsgKey >= 26){
            //   D_NewMsgKey = D_NewMsgKey%26;
            // }
            Ceaser.processDecryptFinal(false, msg, a);
              print(ResultDecryptFinal);
              final currentUser = loggedInUser.displayName;
              final msgBubble = MessageBubble(
                  msgText: ResultDecryptFinal,
                  msgSender: msgSender,
                  user: currentUser == msgSender);
              messageWidgets.add(msgBubble);

          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
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
  final String msgText;
  final String msgSender;
  final String SenderKU;
  final bool user;
  MessageBubble({this.msgText, this.msgSender, this.user,this.SenderKU});

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
                msgText ??"no",
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
