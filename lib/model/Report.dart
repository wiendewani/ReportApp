// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idPelapor,
    this.idAdmin,
    this.idPd,
    this.noTiket,
    this.namaPetugas,
    this.kejadian,
    this.lokasiKejadian,
    this.tanggal,
    this.namaPelapor,
    this.status,
    this.tindakLanjut,
    this.createdAt,
    this.updatedAt,
  });

  String idPelapor;
  String idAdmin;
  String idPd;
  String noTiket;
  String namaPetugas;
  String kejadian;
  String lokasiKejadian;
  DateTime tanggal;
  String namaPelapor;
  String status;
  String tindakLanjut;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPelapor: json["id_pelapor"] == null ? null : json["id_pelapor"],
    idAdmin: json["id_admin"] == null ? null : json["id_admin"],
    idPd: json["id_pd"] == null ? null : json["id_pd"],
    noTiket: json["no_tiket"] == null ? null : json["no_tiket"],
    namaPetugas: json["nama_petugas"] == null ? null : json["nama_petugas"],
    kejadian: json["kejadian"] == null ? null : json["kejadian"],
    lokasiKejadian: json["lokasi_kejadian"] == null ? null : json["lokasi_kejadian"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    namaPelapor: json["nama_pelapor"] == null ? null : json["nama_pelapor"],
    status: json["status"] == null ? null : json["status"],
    tindakLanjut: json["tindak_lanjut"] == null ? null : json["tindak_lanjut"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_pelapor": idPelapor == null ? null : idPelapor,
    "id_admin": idAdmin == null ? null : idAdmin,
    "id_pd": idPd == null ? null : idPd,
    "no_tiket": noTiket == null ? null : noTiket,
    "nama_petugas": namaPetugas == null ? null : namaPetugas,
    "kejadian": kejadian == null ? null : kejadian,
    "lokasi_kejadian": lokasiKejadian == null ? null : lokasiKejadian,
    "tanggal": tanggal == null ? null : "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "nama_pelapor": namaPelapor == null ? null : namaPelapor,
    "status": status == null ? null : status,
    "tindak_lanjut": tindakLanjut == null ? null : tindakLanjut,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
