import 'package:flutter_chatroom/schema/chat_room.dart';
import 'package:flutter_chatroom/schema/latest_news.dart';

class Api {
  Future<List<ChatRoom>> getChatRoomList() async {
    var data = [
      {
        "roomId": "b001",
        "name": "小助理1",
        "latestTime": DateTime.now().toIso8601String(),
        "img":
            "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        "news": "123"
      },
      {
        "roomId": "b002",
        "name": "小助理2",
        "latestTime": DateTime.now().toIso8601String(),
        "img":
            "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        "news": "123"
      }
    ];
    return data.map((e) => ChatRoom.fromJson(e)).toList();
  }

  Future<LatestNews> getLatestNews(
      String roomId, String localChatLogTime) async {
    // roomId 聊天室id, localChatLogTime 该聊天室本地最后更新时间
    // 服务端判断是否需要给客户端新的信息

    var data = {
      "localChatLogTime": "2019-07-08T10:37:28Z",
      "chatLog": [
        {
          "userId": "b001",
          "name": "小助理1",
          "content": "你好阿！我是吸血鬼",
          "time": "2019-07-08T10:37:28Z",
          "img":
              "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        },
        {
          "userId": "b002",
          "name": "小助理2",
          "content": "你好阿",
          "time": "2019-07-08T10:37:28Z",
          "img":
              "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        },
        {
          "userId": "b001",
          "name": "小助理1",
          "content": "你好阿",
          "time": "2019-07-08T10:37:28Z",
          "img":
              "https://img.yxwoo.com:4433/uploads/images/xiaz/2020/0407/1586223138482.jpg",
        }
      ]
    };
    return LatestNews.fromJson(data);
  }
}
