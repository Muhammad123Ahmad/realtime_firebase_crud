import 'package:check1/ui/post/show_post.dart';
import 'package:check1/utils/utils.dart';
import 'package:check1/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final databaseref = FirebaseDatabase.instance.ref('Post'); // creating refrence

  bool loading = false;

  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Post'),
      backgroundColor: Colors.teal,
      centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            const SizedBox(height: 30,),
        
            TextFormField(
              controller: postController,
              maxLines: 3,
              decoration:const InputDecoration(
                hintText: "What is in your mind ?",
              border: OutlineInputBorder(),  
              ),
              
            ),

            const SizedBox(height: 30,),

            RoundButton(
              onTap:(){
              
              setState(() {
                loading = true;
              });

              String id = DateTime.now().millisecondsSinceEpoch.toString();

              databaseref.child(id ).set({

                'id': id,
                'title': postController.text.toString(),


              }).then((value){
                setState(() {
                loading = false;
              });

                Utils().toastMessage('Post Added');

              }).onError((error,stackTrace){
                setState(() {
                loading = true;
              });
                Utils().toastMessage(error.toString());

              });
            } , title: 'Add Data',
            loading: loading,),

            const SizedBox(height: 30,),

            RoundButton(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ShowPostScreen()));
              }
            
            , title: 'Show Data')


          ],
        ),
      ),
    );
  }
}