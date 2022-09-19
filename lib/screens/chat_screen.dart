import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/OVlHlRKnPSkrpcDb4y0H/messages')
              .snapshots(),
          builder: (context,AsyncSnapshot<dynamic>snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data.docs;
            return ListView.builder(
              
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10.0),
                child:  Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
           FirebaseFirestore.instance.collection('chats/OVlHlRKnPSkrpcDb4y0H/messages').add({ 
            'text':'This is the dummy text',
           });
          }),
    );
  }
}
