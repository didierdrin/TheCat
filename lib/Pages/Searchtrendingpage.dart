// Search Trending Page
import 'package:flutter/material.dart';
// Page Imports

class SearchTrendingPage extends StatefulWidget {
  SearchTrendingPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SearchTrendingPageState();
}

class SearchTrendingPageState extends State<SearchTrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: -0.5, top: 10.0),
            child: SizedBox(
              height: 50.0,
              child: Text('Trending Posts',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
