import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:reportapp/model/Report.dart';
import 'package:reportapp/model/ReportDetail.dart';

class ReportProvider with ChangeNotifier{
  Report responeReport;
  ReportDetail responeReportDetail;


  String token = "cf08e7d006f2b613da4ca20b83a21a2b";

  Future<int> getReportDetail(String idReport) async {
    String url = GlobalConfigUrl.report+'/$idReport';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });

      if (response.statusCode == 200) {
        responeReportDetail = reportDetailFromJson(response.body);
        notifyListeners();
      }

      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    } on SocketException catch (_) {
      return 500;
    }
  }
  Future<int> getReport() async {
    String url = GlobalConfigUrl.report;
    print(url);

    String token = "cf08e7d006f2b613da4ca20b83a21a2b";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });

      if (response.statusCode == 200) {
        responeReport = reportFromJson(response.body);
        notifyListeners();
      }

      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    } on SocketException catch (_) {
      return 500;
    }
  }

//  Future<int> postReport(Map<String, String> data) async{
//    final url = GlobalConfigUrl.report;
//
//    final response = await http.post(
//        Uri.parse(url),
//        headers: {
//          HttpHeaders.acceptHeader: "application/json",
//          HttpHeaders.authorizationHeader: "Bearer $token"
//        },
//        body: data
//    );
//    return response.statusCode;
//  }


  Future<int> postReport({
    String id_user,
    String petugas,
    String kejadian,
    String tanggal,
    String nama_pelapor,
    String lokasi_kejadian,
    String tindak_lanjut,
    File dokumentasi,
  }) async {
    final url = GlobalConfigUrl.report;
    print(url);

    try {
      var stream = new http.ByteStream(Stream.castFrom(dokumentasi.openRead()));
      var length = await dokumentasi.length();
      var uri = Uri.parse(url);

      Map<String, String> headers = {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      };

      var request = new http.MultipartRequest('POST', uri);
      var multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(dokumentasi.path));
      request.headers.addAll(headers);

      request.fields['id_user'] = id_user ?? "";
      request.fields['petugas'] = petugas ?? "";
      request.fields['kejadian'] = kejadian ?? "";
      request.fields['tanggal'] = tanggal ?? "";
      request.fields['nama_pelapor'] = nama_pelapor ?? "";
      request.fields['lokasi_kejadian'] = lokasi_kejadian ?? "";
      request.fields['tindak_lanjut'] = nama_pelapor ?? "";
      request.files.add(multipartFile);
      var response = await request.send();
      print("upload image" + "${response.headers}");
      print("upload image" + "${response.statusCode}");

      print(response.statusCode);
      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    } on SocketException catch (_) {
      return 500;
    }
  }
}