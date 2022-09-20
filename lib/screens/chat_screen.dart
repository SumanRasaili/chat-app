import 'package:chatapp/widgets/chats/message.dart';
import 'package:chatapp/widgets/chats/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
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
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdenfier) {
                if (itemIdenfier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(
                child:
                    Messages()),
                    NewMessage(), //here in the message it is in the listview and the listview under column throws error so we need to wrap it in the expanded which is images
                    //it is because listview takes the unbounded height so to minimize it we have to make it under expanded
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.add),
      //     onPressed: () {
      //       FirebaseFirestore.instance
      //           .collection('chats/OVlHlRKnPSkrpcDb4y0H/messages')
      //           .add({
      //         'text': 'This is the dummy text',
      //       });
      //     }),
    );
  }
}
