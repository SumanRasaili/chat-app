
import 'package:chatapp/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<User?> data() async {
      return FirebaseAuth.instance.currentUser;
    }

    return  FutureBuilder(
              future: data(),
              builder: (ctx, AsyncSnapshot<dynamic> futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
    
     return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<dynamic> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                          chatDocs[index]['text'],
                           chatDocs[index]['userId'] == futureSnapshot.data.uid,
                           chatDocs[index] ['userName'],
                           key: ValueKey(chatDocs[index].reference.id,       
                           )
                           );
                    },
                    itemCount: chatDocs.length);
              });
        });
  }
}
