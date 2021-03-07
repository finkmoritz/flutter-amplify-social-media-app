import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media App'),
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(child: Center(child: Text('Feed'))),
          Container(child: Center(child: Text('Friends'))),
          Container(child: Center(child: Text('Settings'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
