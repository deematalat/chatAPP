import 'package:chat_app_class/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_btn.dart';

class RegistrationScreen extends StatefulWidget {
  static const  route='/register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String ?password;
  FirebaseAuth _auth=FirebaseAuth.instance;
  void getLoginState() {
   _auth.authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  initState(){
    getLoginState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Hero(tag:1, child:  Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType:TextInputType.emailAddress,
              onChanged: (value) {
                email=value;
                //Do something with the user input.
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType:TextInputType.visiblePassword,
              obscureText:true,
              onChanged: (value) {
                //Do something with the user input.
                 password=value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
        MainBtn(
          color:Colors.blueAccent,
          text:  'login',
          onPressed: () async {
            if(email!=null&&password!=null) {
              try{
              final  newUser=   await _auth.
              createUserWithEmailAndPassword(email:email!.trim(), password: password!);
              if(newUser!=null&&mounted){  //ان لسا موجود بالسكرين ما طلع منها
                Navigator.pushNamedAndRemoveUntil(context,ChatScreen.route,
                        (r)=>false //بفضي كل الstack
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text('you are logged in ${newUser.user!.email}'))
                );
              }
            }catch(e) {print(e);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text(e.toString()))
              );
              }

          }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text('check your credentials'))
              );
            }
          },

        ),
          ],
        ),
      ),
    );
  }
}
