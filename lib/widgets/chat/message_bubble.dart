import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final Key key;

  MessageBubble(this.message, this.isMe, this.userName, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor),
          width: 140,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1.color),
              ),
              Text(
                message,
                style: TextStyle(
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1.color),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
