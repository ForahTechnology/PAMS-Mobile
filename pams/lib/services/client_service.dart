import 'dart:convert';
import 'package:dio/dio.dart' as prefix;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/add_location_model.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/get_location_response.dart';
import 'package:pams/models/single_test_response_model.dart';
import 'package:pams/models/update_location_model.dart';
import 'package:pams/views/authentication/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientServiceImplementation extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();

  final getAllClientURL = '/Client/GetAllClientField';
  final getClientLocaionUrl =
      '/FieldScientistAnalysisNesrea/get-all-Sample-locations-for-a-Client';
  final addClientLocationURL =
      '/FieldScientistAnalysisNesrea/add-client-location';
  final deleteClientLocationUrl =
      '/FieldScientistAnalysisNesrea/delete-a-client-sample-location/';
  final addDPRTestForEach =
      '/FieldScientistAnalysisDPR/add-dpr-TestResult-ForEachTest';
  ClientServiceImplementation(this.reader) : super(reader);
  final addFMENVTestForEach =
      '/FieldScientistAnalysisFMEnv/add-fmenv-test-Testresult-ForEachTest';
  final addNesreaTestForEach =
      '/FieldScientistAnalysisNesrea/add-nesrea-test-Testresult-ForEachTest';

  //load all clients
  Future<CustomerResponseModel?> getAllClientData() async {
    var token = box.read('token');
    final response = await getHttp(getAllClientURL, token: token);
    print(response.data);
    if (response.responseCodeError == null) {
      return CustomerResponseModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      box.erase();
      Get.offAll(() => AuthPage());
    } else {
      return CustomerResponseModel(status: false);
    }
  }

  // get client location
  Future<LocationResponseModel?> getClientLocation(
      {required String clientId}) async {
    var token = box.read('token');
    final response = await getHttp(getClientLocaionUrl + '?clientId=$clientId',
        token: token);
    if (response.responseCodeError == null) {
      return LocationResponseModel.fromJson(response.data);
    } else {
      return LocationResponseModel(status: false);
    }
  }

  ///Update location
  Future<UpdateLocationResponseModel?> updateClientLocation(
      {required int locationId,
      required String name,
      required String description}) async {
    var token = box.read('token');
    final response = await putHttp(
        "/FieldScientistAnalysisNesrea/Update-a-client-sample-location?SampleLocationId=$locationId&Name=$name&Description=$description",
        null,
        token: token);
    if (response.responseCodeError == null) {
      return UpdateLocationResponseModel.fromJson(response.data);
    } else {
      return UpdateLocationResponseModel(status: false);
    }
  }

  // delete a sample point or client location
  Future<Map<String, dynamic>?> deleteClientLocation(
    int locationId,
  ) async {
    var token = box.read('token');
    final response =
        await deleteHttp(addClientLocationURL + '$locationId', token: token);
    if (response.responseCodeError == null) {
      return jsonDecode(response.data);
    } else {
      return jsonDecode(response.data);
    }
  }

// add sample point or client location
  Future<AddLocationResponseModel?> addClientLocation(
      AddLocationRequestModel model) async {
    var token = box.read('token');
    final response =
        await postHttp(addClientLocationURL, model.toJson(), token: token);
    if (response.responseCodeError == null) {
      return AddLocationResponseModel.fromJson(response.data);
    } else {
      return AddLocationResponseModel(status: false);
    }
  }

  //run one test for dpr
  // run a test for each template
  Future<RunSimpleTestResponseModel> runEACHDPRTest({
    required int Id,
    required int DPRFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    var token = box.read('token');
    var postObj = {
      'Id': Id,
      'DPRFieldId': DPRFieldId,
      'TestLimit': TestLimit,
      'TestResult': TestResult
    };
    final response = await postHttp(addDPRTestForEach, postObj,
        token: token, formdata: true);
    if (response.responseCodeError == null) {
      return RunSimpleTestResponseModel.fromJson(response.data);
    } else {
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //run one test for fmenv
  // run a test for each template
  Future<RunSimpleTestResponseModel> runEACHFMENVTest({
    required int Id,
    required int FMEnvFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    var token = box.read('token');
    var postObj = {};

    final response = await postHttp(
      addFMENVTestForEach +
          '?Id=$Id&FMEnvFieldId=$FMEnvFieldId&TestLimit=$TestLimit&TestResult=$TestResult',
      postObj,
      token: token,
    );
    if (response.responseCodeError == null) {
      return RunSimpleTestResponseModel.fromJson(response.data);
    } else {
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //run one test for nesrea
  // run a test for each template
  Future<RunSimpleTestResponseModel> runEACHNESREATest({
    required int Id,
    required int NesreaFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    var token = box.read('token');
    var postObj = {};

    final response = await postHttp(
      addNesreaTestForEach +
          '?Id=$Id&NesreaFieldId=$NesreaFieldId&TestLimit=$TestLimit&TestResult=$TestResult',
      postObj,
      token: token,
    );
    if (response.responseCodeError == null) {
      return RunSimpleTestResponseModel.fromJson(response.data);
    } else {
      return RunSimpleTestResponseModel(status: false);
    }
  }
}