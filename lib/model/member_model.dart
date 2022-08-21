class MemberModel{
  String? name;
  String? info;
  String? age;



  MemberModel({
    this.name,
    this.info,
    this.age,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    name: json["name"],
    info: json["info"],
    age: json["age"],
  );
}

class MemberTestModel {
  List<User>? user;

  MemberTestModel({this.user});

  MemberTestModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? name;
  String? info;
  String? age;

  User({this.name, this.info, this.age});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    info = json['info'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['info'] = this.info;
    data['age'] = this.age;
    return data;
  }
}
