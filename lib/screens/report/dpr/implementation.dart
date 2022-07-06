import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pams/screens/clients/dpr/submit_data_model.dart';
import 'package:pams/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_all_dpr_submitted_test.dart';

class SubmittedDPRImplementation {
  // get client location
  Future<GetAllDprSubmittedTest?> getDPRSubmittedResult(int? pageNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisDPR/GetAllDPRSubmittedTestByAnalystId?pageSize=10&pageNumber=$pageNumber";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
      print(response.body);
      return getAllDprSubmittedTestFromJson(response.body);
    } catch (e) {}
  }


}




