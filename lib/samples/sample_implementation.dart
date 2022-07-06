import 'package:dio/dio.dart';
import 'package:pams/samples/data/microbial/data_models.dart';
import 'package:pams/samples/data/microbial/database_helper.dart';
import 'package:pams/samples/data/physioco/data_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'data/physioco/database_helper.dart';

class SampleImplementation {
  Future<Map<String, dynamic>?> getClientsTemplates(var clientId) async {
    var url =
        'http://sethlab-001-site1.itempurl.com/api/v1/Sample/$clientId/SampleTemplates';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api = prefs.getString('apiToken');
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $api',
    });

    final int statusCode = response.statusCode;
    //print("my code ${response.body}");
    return Map.from(jsonDecode(response.body));
  }

  //submit test result to the database
  Future<Map<String, dynamic>?> SubmitTest(
      String base64, String clientId) async {
    var url = 'http://sethlab-001-site1.itempurl.com/api/v1/Sample/sampling';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //list of microbial test
    List<MicroBial> micro = await DataBaseHelper.instance.getMicrobial();

    var microList = micro.map((e) => e.toMap()..remove('id')).toList();

    //physico list test
    List<PhysiCo> physico = await PhysicoDataBaseHelper.instance.getPhysiCo();

    var physicoList = physico.map((e) => e.toMap()..remove('id')).toList();

    var api = prefs.getString('apiToken');
    var staffName = prefs.getString('fullname');
    var staffId = prefs.getString('userId');
    var body = {
      "staffName": "$staffName",
      "staffId": "$staffId",
      "samplingTime": "10:52",
      "samplingDate": "12/4/2021",
      "clientId": "$clientId",
      "gpsLong": 0.93318,
      "gpsLat": 0.92998,
      "picture": "$base64",
      "microBiologicals": microList,
      "physicoChemicals": physicoList
    };
    Response response;
    var dio = Dio();
    response = await dio.post(url,
        data: body,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $api',
        }));
    print(response.data.toString());
    return Map.from(response.data);
  }
}
