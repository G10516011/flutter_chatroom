import 'package:flutter/material.dart';
import 'package:flutter_chatroom/router/index.dart';
import 'package:flutter_chatroom/schema/chat_room.dart';
import 'package:flutter_chatroom/services/api.dart';
import 'package:get/get.dart';

import 'store/chatroom_store.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  late ChatroomStore controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatroomStore());
    controller.getChatRoomList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatroomStore>(builder: (controller) {
      if (controller.ChatRoomData.isEmpty) {
        return SizedBox();
      }
      return Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: controller.ChatRoomData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                   PageRoutes.addRouter(routeName: PageName.roomPage,parameters: {
                    "roomId": controller.ChatRoomData[index].roomId!,
                  },);
                },
                child: ChatRoomItem(chatRoom: controller.ChatRoomData[index]),
              );
            },
          ),
        ),
      );
    });
  }
}

class ChatRoomItem extends StatelessWidget {
  ChatRoomItem({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 16, top: 5, bottom: 5),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            '${chatRoom.img}',
            height: 40,
            width: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${chatRoom.name}'),
              Text("${chatRoom.news}"),
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${DateTime.parse(chatRoom.latestTime!).year.toString()}" +
                  "-" +
                  "${DateTime.parse(chatRoom.latestTime!).month.toString()}" +
                  "-" +
                  "${DateTime.parse(chatRoom.latestTime!).day.toString()}"),
            ],
          ),
        ],
      ),
    );
  }
}
