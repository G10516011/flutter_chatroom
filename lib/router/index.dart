import 'package:flutter_chatroom/pages/home/home.dart';
import 'package:flutter_chatroom/pages/room/room_page.dart';
import 'package:get/get.dart';

class PageName {
  static String home = '/home';
  static String roomPage = '/roomPage';
}

class PageRoutes {
  static final String initRoute = PageName.home;
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: PageName.home,
      page: () =>  Home(),
    ),
    GetPage(
      name: PageName.roomPage,
      page: () =>  RoomPage(),
    ),
  ];

  static addRouter({
    required String routeName,
    Map<String, String>? parameters,
  }) async {
    // 再router入栈
    Get.toNamed(
      routeName,
      parameters: parameters,
    );
  }
}
