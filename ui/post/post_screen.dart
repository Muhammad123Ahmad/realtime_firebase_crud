import 'package:check1/ui/auth/login_screen.dart';
import 'package:check1/ui/post/add_post.dart';
import 'package:check1/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  (const Text('Home',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.teal,

        actions: [IconButton(onPressed: (){
          auth.signOut().then((value) {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
          }).onError((error,stackTrace){
            Utils().toastMessage(error.toString());

          });
        }, icon: const Icon(Icons.logout))],
        ),

        floatingActionButton: FloatingActionButton(onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));
        },

        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        
        ),
        
    );
  }
}