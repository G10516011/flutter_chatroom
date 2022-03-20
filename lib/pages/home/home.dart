import 'package:flutter/material.dart';
import 'package:flutter_chatroom/pages/chatroom/chatroom_page.dart';
import 'package:flutter_chatroom/pages/me/me.dart';
import 'package:flutter_chatroom/store/user_store.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController(initialPage: 0);


  late UserStore userStore;

  @override
  void initState() {
    super.initState();
    userStore = Get.put(UserStore());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            Chatroom(),
            Me(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
      items: _items(),
    );
  }

  List<BottomNavigationBarItem> _items() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.title),
          title: Text('Chatroom'),
        ),
     const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Me'),
        ),
    ];
  }
}
