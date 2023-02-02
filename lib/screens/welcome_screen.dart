import 'package:chat_app_class/screens/chat_screen.dart';
import 'package:chat_app_class/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_btn.dart';
import 'loginscreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static const  route='/';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  Duration duration=Duration(seconds:1);
  late Animation   animation ;
  @override
  void initState() {
    controller=AnimationController(vsync:this,duration:duration );
    controller.forward();
    controller.addListener(
            () {
              print(controller.value);
                   setState(() {});
              print(controller.status);
                   });
    animation=CurvedAnimation(parent:controller, curve:Curves.easeInOut);
   animation=Tween(begin:0,end:1).animate(controller);
    animation.addListener(() {
      setState(() {});
       print(controller.value);
    });
    animation.addStatusListener((status) {
      if(animation==AnimationStatus.dismissed)
      {
          controller.forward();
      }
      if(animation==AnimationStatus.completed)
      {
        controller.reverse();
      }
    });
    FirebaseAuth.instance.authStateChanges().listen(( user)
    {
      if( user!=null){
        Navigator.pushNamedAndRemoveUntil(context, ChatScreen.route, (route) => false);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
             Hero(tag:1, child:Container(
                  child: Image.asset('images/logo.png'),
                  height:controller.value*100,
                ),),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Chat App',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],

                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            MainBtn(
              color:Colors.lightBlueAccent ,
                text:'Log In',
                onPressed: () {
                  Navigator.pushNamed(context,LoginScreen.route);
                },

            ),

            MainBtn(
              color:Colors.blueAccent,
              text:  'Register',
              onPressed: () {
                Navigator.pushNamed(context,RegistrationScreen.route);
              },

            ),

          ],
        ),
      ),
    );
  }
}
