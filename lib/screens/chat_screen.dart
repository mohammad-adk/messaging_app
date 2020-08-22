import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_message/widgets/chat/messages.dart';
import 'package:my_message/widgets/chat/new_message.dart';

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
              body: Container(
                child: Column(
                  children: [
                    Expanded(child: Messages()),
                    NewMessage(),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(),
          );
        });
  }
}
