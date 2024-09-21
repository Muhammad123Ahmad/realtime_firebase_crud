import 'package:check1/ui/post/add_post.dart';
import 'package:check1/utils/utils.dart';
import 'package:check1/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key});

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {

  final ref = FirebaseDatabase.instance.ref('Post');
  final searchText = TextEditingController();
    final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Show Data'),
        centerTitle: true,
        automaticallyImplyLeading: false ,
        

        backgroundColor: Colors.teal,
      ),

      body: Column(
        children: [

          const SizedBox( height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchText,
              decoration:const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            onChanged: (String value){
              setState(() {
                
              });
            },
            ),
            
          ),


Expanded(


  // contains code for search bar and dislpay the data 
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context,snapshot,animation,index){

                final title = snapshot.child('title').value.toString();

                if (searchText.text.isEmpty)
                {
                  return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  subtitle:  Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                      value: 1,
                      child: 
                      ListTile(

                        leading: const Icon(Icons.edit),
                        title: const Text('Edit'),

                        onTap: (){
                          Navigator.pop(context);
                          showMyDialog(title,snapshot.child('id').value.toString());
                          

                        },
                      )),

                       PopupMenuItem(
                      value: 1,
                      child: 
                      ListTile(

                        leading:const Icon(Icons.delete),
                        title:const Text('Delete'),

                        onTap: (){

                          // delete data code

                          ref.child(snapshot.child('id').value.toString()).remove();

                        },
                      )),
                    ] 
                  ),
                  

                );

                }

                else if(title.toLowerCase().contains(searchText.text.toLowerCase())) {
                  return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  subtitle:  Text(snapshot.child('id').value.toString()),

                );

                }
                else{ // if search value not found return empty container
                  return Container();  
                }

                
              }),
          ),

/*

// Code to get simple data without search bar
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context,snapshot,animation,index){

                return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  subtitle:  Text(snapshot.child('id').value.toString()),

                );
              }),
          ),

*/
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(onTap: (){
            
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPostScreen()));
            
            }, title: 'Add new data'),
          )

          

        ],
      ),


    );
    
  }

  // function contains code for edit text
  Future<void> showMyDialog( String title, String id)async{
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context){

        return  AlertDialog(

          title:  const Text('Update'),
          content: Container(
          child: TextField(
            controller: editController,

          ),
          ),
          actions: [
             TextButton(onPressed: (){ Navigator.pop(context);}, child: const Text('Cancel')),
             TextButton(onPressed: (){ 
              Navigator.pop(context);
              ref.child(id).update({
                'title' : editController.text.toLowerCase(),


              }).then((value){

                Utils().toastMessage('Post Added Successfully');

              }).onError((error,stackTrace){
                Utils().toastMessage(error.toString());

              });
             
             }, child: const Text('Update')), 
          ],

        );



      }

    );

  }
// function for edit text ends here 
  
}