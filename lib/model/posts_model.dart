class PostModel {
  String? name;
  String? time;
  String? image;
  String? uId;
  String? imagePost;
  String? text;
  bool? like;
  int? idPost;

  PostModel({
    this.name,
    this.time,
    this.image,
    this.uId,
    this.imagePost,
    this.text,
    this.like,
    this.idPost,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json["name"],
        time: json["time"],
        image: json["image"],
        uId: json["uId"],
        imagePost: json["imagePost"],
        text: json["text"],
        like: json["like"],
        idPost: json["idPost"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "image": image,
        "uId": uId,
        "imagePost": imagePost,
        "text": text,
        "like": like,
        "idPost": idPost,
      };
}

class CommentModel {
  String? name;
  String? time;
  String? image;
  String? uId;
  String? text;

  CommentModel({
    this.name,
    this.time,
    this.image,
    this.uId,
    this.text,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    name: json["name"],
    time: json["time"],
    image: json["image"],
    uId: json["uId"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": time,
    "image": image,
    "uId": uId,
    "text": text,
  };
}