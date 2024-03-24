import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/component/my_button.dart';
import 'package:untitled/component/my_text_field.dart';
import 'package:untitled/services/auth/auth_services.dart';

class RegisterPage extends StatefulWidget{
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() =>_RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{

  final emailController =TextEditingController();
  final passwordController = TextEditingController();
  final pass2Controller = TextEditingController();

  Future<void> signup() async {
    if(passwordController.text!= pass2Controller.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("password is don't match"))
      );
      return;
    }

    final authService =Provider.of<AuthServices>(context,listen:false);
    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
              const SizedBox(height: 20),
              MyTextField(controller: passwordController,
                hintText: 'Password', obscureText: false, keyboardType:TextInputType.text,),
              const SizedBox(height: 20),
              MyTextField(controller: pass2Controller,
                hintText: 'Con Password', obscureText: false, keyboardType:TextInputType.text,),
                MyButton(onTap: signup, text: "Sign Up"),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text(" member"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap:widget.onTap,
                    child: const Text(
                    "Login now",style: TextStyle(
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