// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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
    this.instansi,
  });

  String idUser;
  String idPd;
  String namaPetugas;
  String username;
  String password;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  Instansi instansi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUser: json["id_user"] == null ? null : json["id_user"],
    idPd: json["id_pd"] == null ? null : json["id_pd"],
    namaPetugas: json["nama_petugas"] == null ? null : json["nama_petugas"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    level: json["level"] == null ? null : json["level"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    instansi: json["instansi"] == null ? null : Instansi.fromJson(json["instansi"]),
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
    "instansi": instansi == null ? null : instansi.toJson(),
  };
}

class Instansi {
  Instansi({
    this.id,
    this.namaInstansi,
    this.alamat,
    this.kontak,
    this.email,
    this.website,
    this.ig,
    this.twitter,
    this.fb,
  });

  String id;
  String namaInstansi;
  String alamat;
  String kontak;
  String email;
  String website;
  String ig;
  String twitter;
  String fb;

  factory Instansi.fromJson(Map<String, dynamic> json) => Instansi(
    id: json["id"] == null ? null : json["id"],
    namaInstansi: json["nama_instansi"] == null ? null : json["nama_instansi"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    kontak: json["kontak"] == null ? null : json["kontak"],
    email: json["email"] == null ? null : json["email"],
    website: json["website"] == null ? null : json["website"],
    ig: json["ig"] == null ? null : json["ig"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    fb: json["fb"] == null ? null : json["fb"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama_instansi": namaInstansi == null ? null : namaInstansi,
    "alamat": alamat == null ? null : alamat,
    "kontak": kontak == null ? null : kontak,
    "email": email == null ? null : email,
    "website": website == null ? null : website,
    "ig": ig == null ? null : ig,
    "twitter": twitter == null ? null : twitter,
    "fb": fb == null ? null : fb,
  };
}
