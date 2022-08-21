class SocialModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool ?isVar ;
  String? image;
  String? bio;

  SocialModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isVar,
    this.image,
    this.bio,
  });

  factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    uId: json["uId"],
    isVar: json["isVar"],
    image: json["image"],
    bio: json["bio"],
  );
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "uId": uId,
    "isVar": isVar,
    "image": image,
    "bio": bio,
  };



}