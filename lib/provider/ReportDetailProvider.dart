import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:reportapp/model/ReportDetail.dart';

class ReportDetailProvider with ChangeNotifier{

  String token = "cf08e7d006f2b613da4ca20b83a21a2b";
  ReportDetail responeReportDetail;

  Future<int> getReportDetail(String idReport) async {
    String url = GlobalConfigUrl.report+'/$idReport';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });

      if (response.statusCode == 200) {
        responeReportDetail = reportDetailFromJson(response.body);
        print(response.body);
        notifyListeners();
      }

      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    } on SocketException catch (_) {
      return 500;
    }
  }
}