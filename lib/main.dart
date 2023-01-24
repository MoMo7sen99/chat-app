import 'package:chatapp/components/const.dart';
import 'package:chatapp/modules/chat_screen.dart';
import 'package:chatapp/modules/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'modules/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( const MohsenChat());
}

class MohsenChat extends StatelessWidget {
  const MohsenChat({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute : LoginScreen.id ,

      routes:{
        LoginScreen.id     :    (context) => LoginScreen(),
        RegisterScreen.id  :    (context) => RegisterScreen(),
        ChatScreen.id      :    (context) => ChatScreen(),
      },

      theme: ThemeData(
        primaryColor: KPrimaryColor,
        appBarTheme: const AppBarTheme(
          color: KPrimaryColor,
        ),
      ),


    );
  }
}
