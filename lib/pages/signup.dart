
import 'dart:async';

import 'package:chatcrypto/Services/COnverter.dart';
import 'package:chatcrypto/Services/CeaserCipher.dart';
import 'package:chatcrypto/pages/chatterScreen.dart';
import 'package:chatcrypto/widgets/custombutton.dart';
import 'package:chatcrypto/widgets/customtextinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../Result.dart';

class ChatterSignUp extends StatefulWidget {
  @override
  _ChatterSignUpState createState() => _ChatterSignUpState();
}

class _ChatterSignUpState extends State<ChatterSignUp> {
  final _auth = FirebaseAuth.instance;
  String email;
  // String username;
  String password;
  String name;
  bool signingup = false;
  int KU;
  int seven = 7;
  int two = 2;
  final _firestore = Firestore.instance;
  @override


  void SaveData(String userid) async {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    int ku = email.length - name.length;
    int nameLength =name.length;
    if(ku >=10 ){
      int a  = ku - seven;
      KU =a;
        if(KU >= 10){
          int b  = KU - two;
          KU= b;
        }
    }

    print(KU);
    String key = KU.toString();
    await Ceaser.processE2(true, key , nameLength);
    print(Result3);
    await _firestore.collectionGroup("Peoples").reference().document("Users").collection(uid).add({
      "Name": name,
      "email": email,
      "password": password,
      "Ku": Result3,
    }).then((value) => _showtimer());
    // if(ku >= 26){
    //   int  a=  ku%26;
    //   if(a >= 10){
    //
    //   }
    //    Ku = a.toString();
    //  await Ceaser.processE2(true, Ku, nameLength);
    //   print(Result3);
    //   await _firestore.collectionGroup("Peoples").reference().document("Users").collection(uid).add({
    //     "Name": name,
    //     "email": email,
    //     "password": password,
    //     "Ku": Result3,
    //   }).then((value) => _showtimer());
    // }else{
    //   String _ku = ku.toString();
    //   // await Ceaser.processE2(true, _ku, nameLength);
    //   // print(Result3);
    //   // await _firestore.collectionGroup("Peoples").reference().document("Users").collection(uid).add({
    //   //   "Name": name,
    //   //   "email": email,
    //   //   "password": password,
    //   //   "Ku": Result3,
    //   // }).then((value) => _showtimer());
    // }

  }

  _showtimer() {
    Timer(
      Duration(seconds: 3),
          () {
        // _btnController.success();
      },
    );
  }
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: signingup,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'heroicon',
                    child: Icon(
                      Icons.textsms,
                      size: 120,
                      color: Colors.deepPurple[900],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Hero(
                    tag: 'HeroTitle',
                    child: Text(
                      'Chatter',
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextInput(
                    hintText: 'Name',
                    leading: Icons.text_format,
                    obscure: false,
                    userTyped: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Email',
                    leading: Icons.mail,
                    keyboard: TextInputType.emailAddress,
                    obscure: false,
                    userTyped: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Password',
                    leading: Icons.lock,
                    keyboard: TextInputType.visiblePassword,
                    obscure: true,
                    userTyped: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'signupbutton',
                    child: CustomButton(
                      onpress: () async {
                        if (name != null && password != null && email != null) {
                          setState(() {
                            signingup = true;
                          });
                          try {
                            final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                            if (newUser != null) {
                              UserUpdateInfo info = UserUpdateInfo();
                              info.displayName = name;

                              await newUser.user.updateProfile(info);
                              if (newUser != null) {
                                String uid = newUser.user.uid;
                                SaveData(uid);
                              }
                              Navigator.pushNamed(context, '/login');
                            }
                          } catch (e) {
                            setState(() {
                              signingup = false;
                            });
                            EdgeAlert.show(context,
                                title: 'Signup Failed',
                                description: e.toString(),
                                gravity: EdgeAlert.BOTTOM,
                                icon: Icons.error,
                                backgroundColor: Colors.deepPurple[900]);
                          }
                        } else {
                          EdgeAlert.show(context,
                              title: 'Signup Failed',
                              description: 'All fields are required.',
                              gravity: EdgeAlert.BOTTOM,
                              icon: Icons.error,
                              backgroundColor: Colors.deepPurple[900]);
                        }
                      },
                      text: 'sign up',
                      accentColor: Colors.white,
                      mainColor: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'or log in instead',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.deepPurple),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
