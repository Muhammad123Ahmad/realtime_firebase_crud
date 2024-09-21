import 'package:check1/ui/auth/login_screen.dart';
import 'package:check1/ui/post/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/*

// code for simple splash screen

class  SplashService {
  void isLogin(BuildContext context){

    Timer(const Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen())));

  }
}

*/

// code for splash screen + check if user alredy login then should move to home screen
class  SplashService {

  
  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

  final user =  auth.currentUser;

  if (user != null ){ // means already login

    Timer(const Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen())));

  }
  else{
    Timer(const Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen())));

  }

    

  }
}