import 'package:chat_app_class/screens/chat_screen.dart';
import 'package:chat_app_class/screens/loginscreen.dart';
import 'package:chat_app_class/screens/registration_screen.dart';
import 'package:chat_app_class/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());

              }

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.route ,
      routes:{
        WelcomeScreen.route:(context)=>WelcomeScreen(),
         LoginScreen.route:(context)=>LoginScreen(),
        RegistrationScreen.route:(context)=>RegistrationScreen(),
        ChatScreen.route:(context)=>ChatScreen(),
      },
    );
  }
}
