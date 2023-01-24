import 'package:chatapp/components/components.dart';
import 'package:chatapp/components/const.dart';
import 'package:chatapp/modules/chat_screen.dart';
import 'package:chatapp/modules/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/helper.dart';

class LoginScreen extends StatefulWidget {

   LoginScreen({Key? key}) : super(key: key);

   static String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey() ;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {




    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [

                  const SizedBox(height: 70,),

                  Image.asset(
                    KLogo,
                    height: 120,
                    width: 120,
                    color: Colors.white,
                  ),


                  const SizedBox(height: 10,),


                  const Center(
                    child:  Text(
                      "Mohsen's Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),


                  const SizedBox(height: 40,),


                  Row(
                    children: const [
                       Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 12,),


                  buildTextFormField(
                    label: "Email",
                    hint: "Email",
                    onChanged: (value){
                      email= value;
                    }
                  ),


                  const SizedBox(height: 10,),


                  buildTextFormField(
                    label: "Password",
                    hint: "Password",
                    isPassword: true,
                    onChanged: (value){
                      password = value ;
                    }
                  ),


                  const SizedBox(height: 20,),


                  buildBottom(
                      label: "Sign In",
                      onTap: () async {
                        if (formKey.currentState!.validate()){
                          isLoading = true;
                          setState(() {
                          });
                          try {
                            await signIn();
                            showSnackBar(context, "Success", Colors.green);
                            Navigator.pushNamed(context, ChatScreen.id,arguments: email );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, "user not found", Colors.red);
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'Wrong password Please try again ' , Colors.red);
                            }
                          } catch (e){
                              showSnackBar(
                              context, "error, please try again", Colors.red);
                          }
                          isLoading = false;
                          setState(() {});
                        } else {}
                      }
                      ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?",
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ) ,
                      ),
                      TextButton(
                          child: const Text("Register ",
                            style:TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ) ,
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> signIn() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
