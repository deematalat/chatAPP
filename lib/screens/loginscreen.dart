import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_btn.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
      static const   route='/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  bool showSpanner=false;
  String ?password;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:!showSpanner ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType:TextInputType.emailAddress,
              onChanged: (value) {
                email=value;
                //Do something with the user input.
              },
              decoration:kTextFieldDecurtion.copyWith(
                hintText: 'Enter your Email'
              )
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType:TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                password=value;
                //Do something with the user input.
              },
              decoration:kTextFieldDecurtion.copyWith(
                  hintText: 'Enter your Password'
              ) ,
            ),
            SizedBox(
              height: 24.0,
            ),
        MainBtn(
            color:Colors.lightBlueAccent,
            text:  'login',
            onPressed:   () async {
              if(email!=null&&password!=null) {
                try{
                  final  newUser=   await _auth.
                   signInWithEmailAndPassword(email:email!.trim(), password: password!);
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
              setState(() {
                showSpanner=false;
              });
            },

      ),
          ],
        ),
      ):Center(child: CircularProgressIndicator())
    );
  }
}
const   kTextFieldDecurtion=
InputDecoration(
  hintText: 'Enter your email',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);