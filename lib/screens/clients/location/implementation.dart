import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pams/screens/clients/location/model/add_location_model.dart';
import 'package:pams/screens/clients/location/model/add_location_request_model.dart';
import 'package:pams/screens/clients/location/model/delete_location_model.dart';
import 'package:pams/screens/clients/location/model/update_location_model.dart';
import 'package:pams/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/get_location_response.dart';

class LocationImplementation {
  // get client location
  Future<LocationResponseModel?> getClientLocation(String? clientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisNesrea/get-all-Sample-locations-for-a-Client?clientId=$clientId";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
      return locationResponseModelFromJson(response.body);
    } catch (e) {}
  }

  ///Update location
  Future<UpdateLocationResponseModel?> updateClientLocation(
      int locationId, String name, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisNesrea/Update-a-client-sample-location?SampleLocationId=$locationId&Name=$name&Description=$description";

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
      return updateLocationResponseModelFromJson(response.body);
    } catch (e) {}
  }

  Future<Map<String, dynamic>?> deleteClientLocation(
    int locationId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      "content-type": "application/json",
      "accept": "application/json",
      'Authorization': 'Bearer $token'
    };

    var url = Constants.base_url +
        "/FieldScientistAnalysisNesrea/delete-a-client-sample-location/$locationId";

    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: requestHeaders,
      );
      // SHARED
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {}
  }

  Future<AddLocationResponseModel?> addClientLocation(
      AddLocationRequestModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');

    Map<String, String> requestHeaders = {
      "content-type": "application/json",
      "accept": "application/json",
      'Authorization': 'Bearer $token'
    };
    var body = jsonEncode(model.toJson());

    var url = Constants.base_url +
        "/FieldScientistAnalysisNesrea/add-client-location";

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: requestHeaders,
      );
      // SHARED
      print(response.body);
      print(body);
      return addLocationResponseModelFromJson(response.body);
    } catch (e) {}
  }

  // // make payment request
  // static Future<bool> makePayment(MakePaymentRequestModel model) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   try {
  //     var response = await http.post(
  //       Uri.parse(apiUrl + "/BillsPayment/Payment"),
  //       headers: requestHeaders,
  //     );

  //     print(response.body);
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

}
