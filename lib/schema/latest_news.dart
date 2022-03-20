import 'chat_log.dart';

class LatestNews {
  String? localChatLogTime;
  List<ChatLog>? chatLog;

  LatestNews({this.localChatLogTime, this.chatLog});

  LatestNews.fromJson(Map<String, dynamic> json) {
    localChatLogTime = json['localChatLogTime'];
    if (json['chatLog'] != null) {
      chatLog = <ChatLog>[];
      json['chatLog'].forEach((v) {
        chatLog!.add(new ChatLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localChatLogTime'] = this.localChatLogTime;
    if (this.chatLog != null) {
      data['chatLog'] = this.chatLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}