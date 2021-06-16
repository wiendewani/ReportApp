// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.idUser,
    this.idPd,
    this.namaPetugas,
    this.username,
    this.password,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  String idUser;
  String idPd;
  String namaPetugas;
  String username;
  String password;
  String level;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUser: json["id_user"] == null ? null : json["id_user"],
    idPd: json["id_pd"] == null ? null : json["id_pd"],
    namaPetugas: json["nama_petugas"] == null ? null : json["nama_petugas"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    level: json["level"] == null ? null : json["level"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "id_pd": idPd == null ? null : idPd,
    "nama_petugas": namaPetugas == null ? null : namaPetugas,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "level": level == null ? null : level,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
