

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.isMe, this.userName,
      {required this.key});
  final String message;
  final String userName;
  final Key key;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: isMe
                      ? Colors.grey[300]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  )),
              width: 140,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  //its not done because it updates the username for every scroll. so we pass username through the widget
                  // FutureBuilder(
                  //     future: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .doc(userName)
                  //         .get(),
                  //     builder: (context,AsyncSnapshot<dynamic> snapshot) {
                  //         if(snapshot.connectionState == ConnectionState.waiting){
                  //           return const  Text('Loading....');
                  //         }
                  Text(userName,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).textTheme.headline1!.color)),

                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).textTheme.headline1!.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ))
        ]);
  }
}
