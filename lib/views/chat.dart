

import 'package:eformapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  String myEmail;
@override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('Detail User'),),
    body: Center(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Text("Loading data...Please wait");
            return Text(
              "Email : $myEmail",
            style: TextStyle(color: Colors.white),);
          },
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null)
      await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data['userEmail'];
        print(myEmail);
      }).catchError((e) {
        print(e);
      });
  }
}
    
