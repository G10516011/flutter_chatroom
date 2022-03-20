class ChatRoom {
  String? roomId;
  String? name;
  String? latestTime;
  String? img;
  String? news;

  ChatRoom({this.roomId,this.name, this.latestTime, this.img, this.news});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    name = json['name'];
    latestTime = json['latestTime'];
    img = json['img'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['name'] = this.name;
    data['latestTime'] = this.latestTime;
    data['img'] = this.img;
    data['news'] = this.news;
    return data;
  }
}