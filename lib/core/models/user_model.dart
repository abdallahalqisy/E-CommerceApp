class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserModel({this.name, this.email, this.phone, this.image, this.token});

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['token'] = token;

    return data;
  }
}
