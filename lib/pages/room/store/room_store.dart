import 'dart:convert';

import 'package:flutter_chatroom/schema/chat_log.dart';
import 'package:flutter_chatroom/schema/latest_news.dart';
import 'package:flutter_chatroom/store/user_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_chatroom/schema/chat_room.dart';
import 'package:flutter_chatroom/services/api.dart';
import 'package:get/get.dart';

class RoomStore extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late String localChatLogTime;
  late String roomId;
  late UserStore userStore;
  List<ChatLog> chatLogs = [];
  List<String> prefsValue = [];

  RoomStore(String id) {
    roomId = id;
    userStore = Get.find<UserStore>();
    _init(roomId);
  }
  _init(String roomId) async {
    prefs = await _prefs;
    // 读取本地历史记录
    await getLocalHistoryRecord();
    // 服务端获取最新记录
    await latestRecord(roomId);
    update(); // 手动刷新
  }


  // 读取本地历史记录
  getLocalHistoryRecord() async {
    List<String>? dataList = await prefs.getStringList(roomId);
    if (dataList == null) return;
    for (var item in dataList) {
      chatLogs.add(ChatLog.fromJson(jsonDecode(item)));
    }
  }

  // 服务端获取最新记录
  latestRecord(String roomId) async {
    LatestNews latestNews =
        await Api().getLatestNews(roomId, "2019-07-08T10:37:28Z");
    
    if (latestNews.chatLog!.isNotEmpty) {
      for (var item in latestNews.chatLog!) {
        chatLogs.add(item);
        prefsValue.add(JsonEncoder().convert(item.toJson()));
      }
    }
    prefs.setStringList(roomId, prefsValue);
  }
  putMessenger(String messenger){
    var messengerMap = {
          "userId": userStore.userId,
          "name": userStore.name,
          "content": messenger,
          "time": DateTime.now().toIso8601String(),
          "img":
              "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        };
    chatLogs.add(ChatLog.fromJson(messengerMap));
    
    prefsValue.add(JsonEncoder().convert(ChatLog.fromJson(messengerMap).toJson()));
    
    prefs.setStringList(roomId, prefsValue);
    update(); // 手动刷新
  }

}
