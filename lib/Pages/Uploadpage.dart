// Upload Page
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
// Image Upload
import 'dart:math';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String title;
  String subtitle;
  String url;
  String url2;

  // Image picking
  File sampleImage;
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  // Video picking
  File sampleVideo;
  Future getVideo() async {
    var tempVideo = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      sampleVideo = tempVideo;
    });
  }

  TextFormField buildTextFormField1() {
    return TextFormField(
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) => value.isEmpty ? 'Please Enter Some Text' : null,
      onSaved: (value) => title = value,
    );
  }

  TextFormField buildTextFormField2() {
    return TextFormField(
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: 'Subtitle',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) => value.isEmpty ? 'Please Enter Some Text' : null,
      onSaved: (value) => subtitle = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Content'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                buildTextFormField1(),
                SizedBox(
                  height: 10,
                ),
                buildTextFormField2(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  child: sampleImage == null
                      ? Text('Select an Image')
                      : enableUpload(),
                ),
                RaisedButton(
                  onPressed: getImage,
                  child:
                      Text('Add Image', style: TextStyle(color: Colors.white)),
                  color: Colors.orange,
                ),
                RaisedButton(
                  onPressed: getVideo,
                  child:
                      Text('Add Video', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: createData,
                child: Text('Create', style: TextStyle(color: Colors.white)),
                color: Colors.green,
              ),
              RaisedButton(
                onPressed: id != null ? readData : null,
                child: Text('Read', style: TextStyle(color: Colors.white)),
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('posts').document(id).get();
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('posts')
          .add({'title': '$title', 'subtitle': '$subtitle', 'image': '$url'});
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully Stored !'),
      ));
    }
  }

  Widget enableUpload() {
    int randomNumber = Random().nextInt(100000);
    String imageTitle = 'image${randomNumber}';
    String videoTitle = 'video${randomNumber}';

    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 200.0, width: 200.0),
          RaisedButton(
              elevation: 7.0,
              child: Text('Upload Image'),
              textColor: Colors.blue,
              onPressed: () async {
                final StorageReference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child(imageTitle);
                final StorageUploadTask task =
                    firebaseStorageRef.putFile(sampleImage);

                var downUrl =
                    await (await task.onComplete).ref.getDownloadURL();

                url = downUrl.toString();

                print("Download URL : $url");

                /* For video upload */

                final StorageReference firebaseStorageRef2 =
                    FirebaseStorage.instance.ref().child(videoTitle);
                final StorageUploadTask task2 = firebaseStorageRef2.putFile(
                    sampleVideo, StorageMetadata(contentType: 'video/mp4'));

                var downUrl2 =
                    await (await task2.onComplete).ref.getDownloadURL();

                url2 = downUrl2.toString();

                print("Download URL: $url2");
              }),
        ],
      ),
    );
  }
}
