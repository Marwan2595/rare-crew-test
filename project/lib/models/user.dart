class User {
  String? username;
  String? password;
  String? name;
  String? phone;
  String? gender;

  User({
    this.username,
    this.password,
    this.name,
    this.phone,
    this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    return data;
  }
}
