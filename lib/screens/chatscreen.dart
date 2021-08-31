import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: 10,
        stream: Firestore.instance
            .collection('/chats/XtrUsUzAIHAsLJvmsBor/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          final docu = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: docu.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(docu[index]['text'].toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('/chats/XtrUsUzAIHAsLJvmsBor/messages')
              .add({'text': 'hyy this text uploded by clicking'});
          // Firestore.instance
          //     .collection('/chats/XtrUsUzAIHAsLJvmsBor/messages')
          //     .snapshots()
          //     .listen((event) {
          //   event.documents.forEach((element) {
          //     print(element['text']);
          //   });
          //   // print(event.documents[0]['text'],);
          // });
        },
      ),
    );
  }
}
