class ChatModel {
String ? text;
String ? time;
String ? senderId;
String ? image;
String ? name;


ChatModel({
this.text,
this.time,
this.senderId,
this.image,
this.name,
});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    text: json["text"],
    time: json["time"],
    senderId: json["senderId"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "time": time,
    "senderId": senderId,
    "image": image,
    "name": name,
  };

}