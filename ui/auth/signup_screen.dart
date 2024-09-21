import 'package:check1/ui/auth/login_screen.dart';
import 'package:check1/utils/utils.dart';
import 'package:check1/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>(); // to check that from field is empty or not 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   bool loading = false;

  FirebaseAuth _auth =FirebaseAuth.instance; //creating instance 

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title:  const Center(child: Text('Sign Up',style: TextStyle(color: Colors.white),)),backgroundColor: Colors.teal,
    ),
      body:   Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: 
       [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(children: [
          
              TextFormField(controller: emailController,
              keyboardType: TextInputType.emailAddress,
          
          decoration: const InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.alternate_email), 
          ),
          
          validator: (value){
            if (value!.isEmpty){
              return 'Enter email';
            }
            return null;
          },
                
          ),
          
          const SizedBox(height: 20,),
           TextFormField(controller: passwordController,
           keyboardType: TextInputType.text,
           obscureText: true,
          
          decoration: const InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_open), 
          ),
          validator: (value){
            if (value!.isEmpty){
              return 'Enter password';
            }
            return null;
          },
          
          ),
          
          ],)),
        ),

        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundButton(
            title: 'Sign up',
            loading: loading,
            
            onTap: (){if (_formkey.currentState!.validate()){  
            setState(() {
                  loading = true;
                });
            _auth.createUserWithEmailAndPassword(
              email: emailController.text.toString(), password: passwordController.text.toString()).then((value){

                setState(() {
                  loading = false;
                });

              }).onError((error,stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });
          }}, ),
        ),

         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const LoginScreen()));
            }, child:const  Text('Login'))
          ],
        )

      ],),
      
  );
  }
}