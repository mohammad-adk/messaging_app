import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      // ignore: missing_return
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
        return Scaffold(
        body: ListView.builder(
            itemCount: 20,
            itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Dummy Text'),
                )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("chats/G6jDihxTtCHPvaqs1Kss/messages")
                .snapshots()
                .listen((data) {
              print(data);
            });
          },
        ),
      );}}
    );
  }
}
