import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home/chat/chat_page.dart';
import 'package:social_media_app/pages/home/feed/feed_page.dart';
import 'package:social_media_app/pages/home/my_profile/my_profile_page.dart';
import 'package:social_media_app/pages/home/notifications/notifications_page.dart';
import 'package:social_media_app/pages/home/search/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  FeedPage _feedPage;
  NotificationsPage _notificationsPage;
  SearchPage _searchPage;
  ChatPage _chatPage;
  MyProfilePage _myProfilePage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _feedPage = FeedPage();
    _notificationsPage = NotificationsPage();
    _searchPage = SearchPage();
    _chatPage = ChatPage();
    _myProfilePage = MyProfilePage();
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
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
        }),
        children: [
          _feedPage,
          _notificationsPage,
          _searchPage,
          _chatPage,
          _myProfilePage,
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
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'My Profile',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_currentIndex) {
      case 0:
        return FloatingActionButton(
          child: Icon(
            Icons.edit,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/feed/newPost');
          },
        );
      default:
        return Container();
    }
  }
}
