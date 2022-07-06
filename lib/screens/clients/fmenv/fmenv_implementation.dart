import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pams/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FMENVImplementation {
  // get client location
  Future<Map<String, dynamic>?> getFMENVTemplates(int? locationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisFMEnv/get-fmenv-template?LocationId=$locationId";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
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
        "/FieldScientistAnalysisFMEnv/add-fmenv-test-Testresult-ForEachTest?TestName=$testName&FMEnvFieldId=$testID&TestLimit=$testLimit&TestResult=$testResult";

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
  Future<Map<String, dynamic>?> submitTest(
    int samplePtId,
    int DPRFieldId,
    String Latitude,
    String Longitude,
    String PmTestLimit,
    int PmTestResult,
    String HmTestLimit,
    int HmTestResult,
    String NoiseTestLimit,
    int NoiseTestResult,
    String NO2TestLimit,
    int No2TestResult,
    String SO2TestLimit,
    int So2TestResult,
    String H2STestLimit,
    int H2STestResult,
    String CombTestLimit,
    int CombTestResult,
    String CO2TestLimit,
    int Co2TestResult,
    String VocTestLimit,
    int VocTestResult,
    String O2TestLimit,
    int O2TestResult,
    String CoTestLimit,
    int CoTestResult,
    String TempTestLimit,
    int TempTestResult,
    String Pm5TestLimit,
    String Pm5TestResult,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisDPR/submit-dpr-test-Testresult?samplePtId=$samplePtId&DPRFieldId=$DPRFieldId&Latitude=$Latitude&Longitude=$Longitude&PmTestLimit=$PmTestLimit&PmTestResult=$PmTestResult&HmTestLimit=$HmTestLimit&HmTestResult=$HmTestResult&NoiseTestLimit=$NoiseTestLimit&NoiseTestResult=$NoiseTestResult&NO2TestLimit=$NO2TestLimit&No2TestResult=$No2TestResult&SO2TestLimit=$SO2TestLimit&So2TestResult=$So2TestResult&H2STestLimit=$H2STestLimit&H2STestResult=$H2STestResult&CombTestLimit=$CombTestLimit&CombTestResult=$CombTestResult&CO2TestLimit=$CO2TestLimit&Co2TestResult=$Co2TestResult&VocTestLimit=$VocTestLimit&VocTestResult=$VocTestResult&O2TestLimit=$O2TestLimit&O2TestResult=$O2TestResult&CoTestLimit=$CoTestLimit&CoTestResult=$CoTestResult&TempTestLimit=$TempTestLimit&TempTestResult=$TempTestResult&Pm5TestLimit=$Pm5TestLimit&Pm5TestResult=$Pm5TestResult";

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
}
