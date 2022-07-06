import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pams/screens/clients/dpr/submit_data_model.dart';
import 'package:pams/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DPRImplementation {
  // get client location
  Future<Map<String, dynamic>?> getDPRTemplates(int? locationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisDPR/get-dpr-template?LocationId=$locationId";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {}
  }

// run a test for each template
  Future<Map<String, dynamic>?> runTest(
      int testID, String testName, String testLimit, String testResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisDPR/add-dpr-test-Testresult-ForEachTest?TestName=$testName&DPRFieldId=$testID&TestLimit=$testLimit&TestResult=$testResult";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
      );
      print(response.body);
      print(url);
      // SHARED
      return jsonDecode(response.body);
    } catch (e) {}
  }

  // rsubmit dpr test
  Future<Map<String, dynamic>?> submitTest(SubmitData model) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');
    var postbody = FormData.fromMap(model.toJson());

    var url = Constants.base_url +
        "/FieldScientistAnalysisDPR/submit-dpr-test-Testresult";
    final response = await dio.post(url,
        data: postbody,
        options: Options(headers: {
          'content-type': 'multipart/form-data',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    print(postbody);
    print(response.data);
    return jsonDecode(response.data);
  }
}











































  // int samplePtId,
  //     int DPRFieldId,
  //     String Latitude,
  //     String Longitude,
  //     String PmTestLimit,
  //     int PmTestResult,
  //     String HmTestLimit,
  //     int HmTestResult,
  //     String NoiseTestLimit,
  //     int NoiseTestResult,
  //     String NO2TestLimit,
  //     int No2TestResult,
  //     String SO2TestLimit,
  //     int So2TestResult,
  //     String H2STestLimit,
  //     int H2STestResult,
  //     String CombTestLimit,
  //     int CombTestResult,
  //     String CO2TestLimit,
  //     int Co2TestResult,
  //     String VocTestLimit,
  //     int VocTestResult,
  //     String O2TestLimit,
  //     int O2TestResult,
  //     String CoTestLimit,
  //     int CoTestResult,
  //     String TempTestLimit,
  //     int TempTestResult,
  //     String Pm5TestLimit,
  //     String Pm5TestResult,