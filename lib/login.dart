import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/component/my_button.dart';
import 'package:untitled/component/my_text_field.dart';
import 'package:untitled/services/auth/auth_services.dart';

class LoginPage extends StatefulWidget{
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() =>_LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final emailController =TextEditingController();
  final passwordController = TextEditingController();
  void signin()async{
  final authService=Provider.of<AuthServices>(context,listen:false);
  try{
    await authService.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text
    );
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),));
  }

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Icon(
                Icons.message,
                size:80
              ),
          const SizedBox(height: 50),
              Text("Welcome"),
          const SizedBox(height: 50),
              MyTextField(controller: emailController,
                    hintText: 'Emaiil', obscureText: false, keyboardType:TextInputType.text,),
              const SizedBox(height: 18),
              MyTextField(controller: passwordController,
                hintText: 'Password', obscureText: true, keyboardType:TextInputType.text,),

              MyButton(onTap:signin, text: "Sign In"),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not member"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap:widget.onTap,
                    child:const Text(
                    "Register now",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}