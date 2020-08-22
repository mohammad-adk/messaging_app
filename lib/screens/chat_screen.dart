import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Flutter Chat'),
                actions: [
                  DropdownButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Logout')
                            ],
                          ),
                        ),
                        value: 'Logout',
                      )
                    ],
                    onChanged: (itemIdentifier){
                      if (itemIdentifier == 'Logout'){
                        FirebaseAuth.instance.signOut();
                      }
                    },
                  )
                ],
              ),
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats/G6jDihxTtCHPvaqs1Kss/messages")
                    .snapshots(),
                builder: (ctx, streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = streamSnapshot.data.documents;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (ctx, index) => Container(
                            padding: EdgeInsets.all(8),
                            child: Text(documents[index].data()['text']),
                          ));
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("chats/G6jDihxTtCHPvaqs1Kss/messages")
                      .add({'text': 'This message added using add button'});
                },
              ),
            );
          }
          return Scaffold(
            body: Container(),
          );
        });
  }
}
