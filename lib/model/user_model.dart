// class UserModel {
//   String? data;
//
//   UserModel({this.data});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['data'] = this.data;
//
//     return data;
//   }
// }
//
class UserModel {
  String? token;
  String? userId;

  UserModel({this.token,this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? '';
    userId = json['userId'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;

    return data;
  }
}