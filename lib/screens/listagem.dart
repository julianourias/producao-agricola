import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseListScreen extends StatefulWidget {
  @override
  _FirebaseListScreenState createState() => _FirebaseListScreenState();
}

class _FirebaseListScreenState extends State<FirebaseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('custo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                // Customize the UI for each item in the list
                return ListTile(
                  title: Text(document['nome']),
                  subtitle:
                      Text(document['descrição'] + " - " + document['data']),
                  trailing: Text(document['valor'].toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
