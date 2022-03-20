class ChatLog {
  String? userId;
  String? name;
  String? content;
  String? time;
  String? img;

  ChatLog({this.userId, this.name, this.content, this.time,this.img});

  ChatLog.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    content = json['content'];
    time = json['time'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['content'] = this.content;
    data['time'] = this.time;
    data['img'] = this.img;
    return data;
  }
}