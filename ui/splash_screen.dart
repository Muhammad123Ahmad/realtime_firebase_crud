import 'package:flutter/material.dart';

import 'package:check1/firebase_services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  SplashService splashScreen = SplashService();
  @override
  void initState(){
    super.initState();
    splashScreen.isLogin(context);
    
  }
    @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen',style: TextStyle(fontSize: 26),),)
    );
  }
}