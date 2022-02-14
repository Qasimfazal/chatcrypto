import 'package:chatcrypto/pages/chatterScreen.dart';
import 'package:chatcrypto/pages/login.dart';
import 'package:chatcrypto/pages/signup.dart';
import 'package:chatcrypto/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatterApp());
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