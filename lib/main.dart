import 'dart:math';

import 'package:chatcrypto/Result.dart';
import 'package:chatcrypto/Services/CeaserCipher.dart';
import 'package:chatcrypto/pages/chatterScreen.dart';
import 'package:chatcrypto/pages/login.dart';
import 'package:chatcrypto/pages/signup.dart';
import 'package:chatcrypto/pages/splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ChatterApp());
  // Ceaser.processE(true,"loi",5);
  // print(Result);
  // Ceaser.processE2(true, "5", 8);
  // print(Result3);
  // Ceaser.process(false, Result3, 8);
  // print(ResultD2);
  // int result= int.parse(ResultD2);
  // Ceaser.processDecryptFinal(false, Result, result);
  // print(ResultDecryptFinal);
 // print(String.fromCharCode(57));
 //  String RandomNumber;
 //  RandomNumber = Random().nextInt(26).toString();
 //  int Randomdata= int.parse(RandomNumber);
 //  print(RandomNumber);
 //  if(Randomdata==0){
 //    Random();
 //  }else {
 //    print(Text("NUmber is" + RandomNumber));
 //  }
}

class ChatterApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',

      theme: ThemeData(textTheme: TextTheme(body1: TextStyle(fontFamily: 'Poppins'),),),
      // home: ChatterHome(),
      initialRoute: '/',
      routes: {
        '/':(context)=>ChatterHome(),
        '/login':(context)=>ChatterLogin(),
        '/signup':(context)=>ChatterSignUp(),
        '/chat':(context)=>ChatterScreen(),
        // '/chats':(context)=>ChatterScreen()
      },
    );
  }
}