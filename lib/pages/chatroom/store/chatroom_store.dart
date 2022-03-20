import 'package:flutter_chatroom/schema/chat_room.dart';
import 'package:flutter_chatroom/services/api.dart';
import 'package:get/get.dart';

class ChatroomStore extends GetxController{

  List<ChatRoom> ChatRoomData = [];

    getChatRoomList() async {
    ChatRoomData = await Api().getChatRoomList();
    update(); // 手动刷新

  }
}