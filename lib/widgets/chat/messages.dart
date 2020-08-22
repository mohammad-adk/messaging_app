import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_message/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          itemCount: chatDocs.length,
          reverse: true,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index].data()['text'],
            chatDocs[index].data()['userId'] == FirebaseAuth.instance.currentUser.uid,
            key: ValueKey(chatDocs[index].documentID),
          ),
        );
      },
    );
  }
}
