// Notification Page
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              leading: Icon(Icons.alarm),
              title: Text('Latest contents',
                  style: TextStyle(
                    fontSize: 15.0,
                  )),
              trailing: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.grey[500],
                ),
                child: Text('Clear', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
