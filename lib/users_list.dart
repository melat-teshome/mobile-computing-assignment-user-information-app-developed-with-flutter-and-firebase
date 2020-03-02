import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_detail.dart';
import 'signout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class ListPage extends StatefulWidget {

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  FirebaseAuth firebaseAuth;
  var firestore = Firestore.instance;

  Future getPosts() async {
    QuerySnapshot qn = await firestore.collection('users').getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post ){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(post: post,)));
  }
  void signOut(String choice) async{
    firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }
  void deleteUsers(docId) async{
    await Firestore.instance.collection('users').document(docId).delete().catchError((e){
        print(e);
    });

    print(docId);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'login',
        theme: new ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('USERS'),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: signOut,
                  itemBuilder: (BuildContext context){
                    return Constants.choices.map((String choice){
                      return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
    ),
    body: Container(
      child: FutureBuilder(
          future: getPosts(),
          builder:(_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text('comming up'),
              );
            }else{
              return ListView.builder(
                itemCount : snapshot.data.length,
                itemBuilder: (_,index){
              return Card(
                child: ListTile(
                  title: Text(snapshot.data[index].data['user name']),
                  onTap: ()=> navigateToDetail(snapshot.data[index]),
                  onLongPress: (){
                   // deleteUsers();
                  },
//                  leading: CircleAvatar(
//                    backgroundImage: NetworkImage('image.jpg'),
//                  ),
                ),
              );
                });
                  }
          }),
    ),
        ));

  }
}

