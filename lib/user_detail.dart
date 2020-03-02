
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final DocumentSnapshot post;
  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data['user name']),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.post.data['user name']),
            subtitle: Text(widget.post.data['mobile']),

          ),
        ),
      ),
    );
  }
}
