import 'package:flutter/material.dart';
import 'package:flutter_chatroom/schema/chat_log.dart';
import 'package:get/get.dart';

import 'store/room_store.dart';

class RoomPage extends StatefulWidget {
  RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late RoomStore roomStore;
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    var args = Get.parameters["roomId"]!;
    print("RoomID " + args);
    roomStore = Get.put(RoomStore(args));
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomStore>(builder: (controller) {
      if (controller.chatLogs.length < 1) {
        return SizedBox();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("${controller.roomId} Room"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                          roomStore.chatLogs.map((e) => messenger(e)).toList(),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.messenger_outline_outlined)),
                    )),
                    ElevatedButton(
                      child: Text("发送"),
                      onPressed: () {
                        controller.putMessenger(textEditingController.text);
                        textEditingController.text = "";
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget messenger(ChatLog e) {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    if (e.userId == roomStore.userStore.userId) {
      crossAxisAlignment = CrossAxisAlignment.end;
      mainAxisAlignment = MainAxisAlignment.end;
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (e.userId != roomStore.userStore.userId) ...[
          Image.network(
            e.img!,
            height: 30,
            width: 30,
          ),
          SizedBox(
            width: 8,
          ),
        ],
        Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              e.name!,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  Text(e.content!, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
        if (e.userId == roomStore.userStore.userId) ...[
          SizedBox(
            width: 8,
          ),
          Image.network(
            e.img!,
            height: 30,
            width: 30,
          ),
        ],
      ],
    );
  }
}
