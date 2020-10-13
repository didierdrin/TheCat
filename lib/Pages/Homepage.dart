// HomePage 
import 'package:flutter/material.dart';
//import 'package:flutter/Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Pages 
import 'Todaypage.dart';
import 'Searchtrendingpage.dart';
import 'Uploadpage.dart';
import 'Notificationpage.dart';
import 'Savedpage.dart';


class HomePage extends StatefulWidget {
	HomePage({Key key, this.title}) : super(key : key);
	final String title;
	@override
	State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
	int selectedIndex = 0;
	final widgetOptions = [
		new TodayPage(),
		new SearchTrendingPage(),
		new SavedPage(),
	];
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text(widget.title),
				actions: <Widget>[
					IconButton(icon: Icon(Icons.notifications), onPressed: () => _pushPage(context, NotificationPage())),
				],
				),
			drawer: Drawer(
				child: ListView(
					children: <Widget>[
						UserAccountsDrawerHeader(
							accountName: Text('TheCatBabalao'),
							accountEmail: Text('#thecatbabalo'),
							currentAccountPicture: CircleAvatar(
								backgroundImage: AssetImage('assets/logo.png'),
								),
							),
						ListTile(
							leading: Icon(Icons.home),
							title: Text('Home'),
							onTap: () {},
							),
						Divider(
							thickness: 1.0,
							indent: 10.0,
							endIndent: 10.0,
							),

						ListTile(
							leading: Icon(Icons.email),
							title: Text('Contact Us'),
							onTap: () {},
							),
						Divider(
							thickness: 1.0,
							indent: 10.0,
							endIndent: 10.0,
							),
						ListTile(
							leading: Icon(Icons.settings),
							title: Text('Settings'),
							onTap: () {},
							),
						Divider(
							thickness: 1.0,
							indent: 10.0,
							endIndent: 10.0,
							),
						ListTile(
							leading: Icon(Icons.person_pin),
							title: Text('Admin Portal'),
							onTap: () => _pushPage(context, UploadPage()),
							),
						Divider(
							thickness: 1.0,
							indent: 10.0,
							endIndent: 10.0,
							),
					],
					),
				),
			body: widgetOptions.elementAt(selectedIndex),
			bottomNavigationBar: BottomNavigationBar(
				items: <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.home),
						title: Text('Home'),
						),
					BottomNavigationBarItem(
						icon: Icon(Icons.search),
						title: Text('Search'),
						),
					BottomNavigationBarItem(
						icon: Icon(Icons.bookmark),
						title: Text('Saved'),
						),
				],
				currentIndex: selectedIndex,
				fixedColor: Colors.redAccent,
				onTap: onItemTapped,
				),
			);
	}

	void onItemTapped(int index) {
		setState(() {
			selectedIndex = index;
			});
	}

	void _pushPage(BuildContext context, page) {
		Navigator.of(context).push(
			MaterialPageRoute<void>(builder: (_) => page),
			);
	}
}

