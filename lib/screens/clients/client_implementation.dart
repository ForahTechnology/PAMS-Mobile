import 'package:http/http.dart' as http;
import 'package:pams/screens/clients/customer_response_model.dart';
import 'package:pams/utils/constants.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ClientImplementation {
  //load all clients
  Future<CustomerResponseModel?> getAllClients(int? pageNumber) async {
    var url =
        'http://sethlab-001-site1.itempurl.com/api/v1/Client/GetAllClient?pageSize=10&pageNumber=$pageNumber';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api = prefs.getString('apiToken');
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $api',
    });

    final int statusCode = response.statusCode;
    //print("my code ${response.body}");
    return CustomerResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>?> createClient(
    String name,
    String email,
    String address,
    String contactPerson,
    String phoneNumber,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Constants.base_url + "/Client/CreateClient";
    var api = prefs.getString('apiToken');

    var postbody = {
      "name": name,
      "email": email,
      "address": address,
      "contactPerson": contactPerson,
      "phoneNumber": phoneNumber,
      "sampleTemplates": [
        {
          "templateId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "type": 0,
        }
      ]
    };

    final response =
        await http.post(Uri.parse(url), body: jsonEncode(postbody), headers: {
      'content-type': 'application/json',
      'accept': '/',
      'Authorization': 'Bearer $api',
    });
    print(response.body);
    return jsonDecode(response.body);
  }
}
