import 'package:flutter/material.dart';
import 'package:lawy/chatPage.dart';
import 'package:lawy/signup.dart';
import 'package:lawy/whatwedo.dart';
import 'package:lawy/navBar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "SignIn",
    routes: {
      'SignIn': (context) => SignInPage(),
      'whatwedo': (context) => WhatWeDoPage(),
      'chatbot': (context) => const ChatPage(),
      'nav': (context) => const NavBar(),
    },
  ));
}
