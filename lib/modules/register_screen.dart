
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/components.dart';
import '../components/const.dart';
import '../helper/helper.dart';


class RegisterScreen extends StatefulWidget {

  static String id = "RegisterScreen";


  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

   String? email  ;

   String? password  ;

  String? error;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey() ;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey ,
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
                      "Register",
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
                  onChanged: (data){
                    email = data.toLowerCase();
                  },
                ),


                const SizedBox(height: 10,),


                buildTextFormField(
                  label: "Password",
                  hint: "Password",
                  isPassword: true,
                  onChanged: (data){
                    password = data;
                  },),


                const SizedBox(height: 20,),


                buildBottom(
                    label: "Register",
                    onTap: () async {
                     if (formKey.currentState!.validate()) {
                       isLoading = true ;
                       setState(() {});
                        try {
                          await registerUser();
                          showSnackBar(
                              context,
                              "Account Successfully generated, Please Sign in",
                              Colors.green);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            error = 'The password provided is too weak.';
                          } else if (e.code == 'email-already-in-use') {
                            error = 'Email-Adress already exist';
                          }
                          showSnackBar(context, error!, Colors.red);
                        } catch (e) {
                          showSnackBar(
                              context, "error, please try again", Colors.red);
                        }

                             isLoading = false ;
                             setState(() { });
                     } else {}
                    }),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        "Sign in ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> registerUser () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email! ,
      password: password! ,
    );
  }
}
