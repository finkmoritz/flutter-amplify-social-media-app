import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: AssetImage('assets/icon.png'),
          ),
        ),
        title: Text('Social Media App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
        }),
        children: [
          Container(child: Center(child: Text('Feed'))),
          Container(child: Center(child: Text('Friends'))),
          Container(child: Center(child: Text('My Profile'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.easeOut);
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
            icon: Icon(Icons.portrait),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }
}
