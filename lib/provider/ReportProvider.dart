import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:reportapp/model/Report.dart';
import 'package:reportapp/model/ReportDetail.dart';
import 'package:reportapp/utils/FieldReport.dart';

class ReportProvider with ChangeNotifier{
  Report responeReport;
  ReportDetail reportDetail;

  List<Report> listReport = [];

  String token = "cf08e7d006f2b613da4ca20b83a21a2b";

  Future<int> getReport() async {
    String url = GlobalConfigUrl.report;
    print(url);

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

  List<File> images = [];
  List<String> imagesNetwork = [];
  List<dynamic> dynamicImages = [];

  void removeImages() {
    images.clear();
    notifyListeners();
  }

  Future<int> postReport({
    Map<String, String> data,
  }) async {
    final url = GlobalConfigUrl.report;

    print("images length ${images.length}");
    try {
      var uri = Uri.parse(url);
      Map<String, String> headers = {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      };
      var request = new http.MultipartRequest('POST', uri);

      images.forEach((element) async {
        var stream = new http.ByteStream(Stream.castFrom(element.openRead()));
        var length = await element.length();

        var multipartFile = new http.MultipartFile(FieldPengajuan.dokumentasi, stream, length,
            filename: basename(element.path));
        request.files.add(multipartFile);
        print(multipartFile);
      });

      request.headers.addAll(headers);
      request.fields.addAll(data);

      request.fields.forEach((key, value) {
        print(key + " : " + value);
      });
      var response = await request.send();

      print("upload image" + "${response.headers}");
      print("upload image" + "${response.statusCode}");
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    } on SocketException catch (_) {
      return 500;
    }
  }
}