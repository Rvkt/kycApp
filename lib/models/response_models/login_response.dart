import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String message;
  User user;
  String token;
  int status;

  LoginResponse({
    required this.message,
    required this.user,
    required this.token,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    user: User.fromJson(json["user"] ?? {}),
    token: json["token"] ?? "",
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
    "token": token,
    "status": status,
  };
}

class User {
  String userId;
  int roleId;
  String mobile;
  String name;

  User({
    required this.userId,
    required this.roleId,
    required this.mobile,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"] ?? "",
    roleId: json["roleId"] ?? -1,
    mobile: json["mobile"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "roleId": roleId,
    "mobile": mobile,
    "name": name,
  };
}

