import 'package:check1/ui/auth/signup_screen.dart';
import 'package:check1/ui/post/post_screen.dart';
import 'package:check1/utils/utils.dart';
import 'package:check1/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>(); // to check that from field is empty or not 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(
      email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
        setState(() {
      loading =false;
    });
        Utils().toastMessage(value.user!.email.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      }).onError((error,stackTrace){
        setState(() {
      loading =false;
    });
        debugPrint(error.toString());// when it go in production mode all the statment of debug mode get remove so speed of production doesnot get slow 
        Utils().toastMessage(error.toString());
      });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title:  const Center(child: Text('Login',style: TextStyle(color: Colors.white),)),backgroundColor: Colors.teal,
      automaticallyImplyLeading:  false,),// remove back error from app bar
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
            loading: loading,
            
            onTap: (){if (_formkey.currentState!.validate()){
              login();
            }}, title: 'Login'),
        ),

         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Don't have account?"),
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const SignUpScreen()));
            }, child:const  Text('Sign up'))
          ],
        )

      ],),
      
  );
  }
}