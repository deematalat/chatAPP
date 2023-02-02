import 'package:chat_app_class/screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const route='/chatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  late User user;
  late TextEditingController controller;
   dynamic masseges;
  void getCurrentUser(){
    user=_auth.currentUser!;
    print(user.email);
  }
  @override
  void initState() {
    controller=new TextEditingController();
    getCurrentUser();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Text(user.email.toString()),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
               // _auth.signOut();
                 //Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (route) => false);
                getMasseges();
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
        masseges==null?Center(child: CircularProgressIndicator()) :Expanded(child:   ListView(
              children: [
        for(var item in masseges.docs)...
          {
            Padding(

               child: Text('${item['text']}',style:TextStyle(
                  fontSize:24,
                ),), padding: EdgeInsets.all(16),
            )
          }
              ],
            ),),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller:controller,
                      onChanged: (value) {

                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(controller.text);
                      controller.clear();
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getMasseges()async{
   masseges= await  _firestore.collection('masseges').get();
   setState(() {});
  for(var item in masseges.docs)
  {
          print(item['text']);
  }

  }
}
