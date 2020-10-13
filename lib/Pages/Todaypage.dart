// Today Page
import 'package:flutter/material.dart';
// Plugins
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:core';

class TodayPage extends StatefulWidget {
  TodayPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TodayPageState();
}

class TodayPageState extends State<TodayPage> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  Map<String, dynamic> data() {
    return null;
  }

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 280.0,
            maxWidth: double.infinity,
          ),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 2.0,
                color: Colors.red,
              ),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 5.0),
                  child: Column(
                    children: <Widget>[
                      Positioned(
                        top: 10.0,
                        left: 80.0,
                        child: SizedBox(
                          height: 250.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('${doc.data()['image']}'),
                                      fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: Alignment(0.0, 1.0),
                                child: Container(
                                  height: 80.0,
                                  color: Colors.white,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                top: 10.0,
                                left: 0.0,
                                child: Text('${doc.data()['title']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Positioned(
                                top: 30.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment(0.0, 0.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        width: 230.0,
                                        child: Text('${doc.data()['subtitle']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    )),
                                        ),
                                      ),

                                    IconButton(icon: Icon(Icons.bookmark), onPressed: () {}, color: Colors.grey[400],),
                                  ],
                                  ),
                                ),
                                    ],
                                    ),
                                  ),
                                ),
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents
                        .map((doc) => buildItem(doc))
                        .toList(),
                  );
                } else {
                  return Container(child: Text('Nothing Displayed !'));
                }
              }),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
