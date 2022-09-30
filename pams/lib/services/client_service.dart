import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/add_location_model.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/dpr_result_activities_model.dart';
import 'package:pams/models/fmenv_result_activity_model.dart';
import 'package:pams/models/get_location_response.dart';
import 'package:pams/models/nesrea_result_activity_model.dart';
import 'package:pams/models/single_test_response_model.dart';
import 'package:pams/models/update_location_model.dart';
import 'package:pams/utils/connection_status.dart';
import 'package:pams/utils/controller.dart';
import 'package:pams/utils/db.dart';
import 'package:pams/utils/db_helpers.dart';
import 'package:pams/views/authentication/auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as multipart;

class ClientServiceImplementation extends ApiManager {
  GetStorage box = GetStorage();
  GetStorage userdata = GetStorage();
  // Creates a customer response model box offline.
  GetStorage customerResponseModel = GetStorage();
  // Read the current state of the controller.
  PamsStateController _controller = Get.put<PamsStateController>(PamsStateController());
  var db = PamsDatabase.init();

  final getAllClientURL = '/Client/GetAllClientField';
  final getClientLocaionUrl = '/FieldScientistAnalysisNesrea/get-all-Sample-locations-for-a-Client';
  final addClientLocationURL = '/FieldScientistAnalysisNesrea/add-client-location';
  final deleteClientLocationUrl = '/FieldScientistAnalysisNesrea/delete-a-client-sample-location/';
  final addDPRTestForEach = '/FieldScientistAnalysisDPR/add-dpr-TestResult-ForEachTest';
  final addFMENVTestForEach = '/FieldScientistAnalysisFMEnv/add-fmenv-test-Testresult-ForEachTest';
  final addNesreaTestForEach = '/FieldScientistAnalysisNesrea/add-nesrea-test-Testresult-ForEachTest';
  final submitDPRTemplate = '/FieldScientistAnalysisDPR/submit-dpr-TestResult';
  final submitFMENVTemplate = '/FieldScientistAnalysisFMEnv/submit-fmenv-test-Testresult';
  final submitNESREATemplate = '/FieldScientistAnalysisNesrea/submit-nesrea-test-Testresult';
  final getDPRResultActivityUrl = '/FieldScientistAnalysisDPR/GetAllDPRTestByAnalystIdWithNoPagination';
  final getFMENVResultActivityUrl = '/FieldScientistAnalysisFMEnv/GetAllFMEnvTestByAnalystIdWithNoPagination';
  final getNesreaResultActivityUrl = '/FieldScientistAnalysisNesrea/GetAllNesreaTestByAnalystIdWithNoPagination';

  //load all clients
  Future<CustomerResponseModel?> getAllClientData() async {
    var token = box.read('token');
    await ConnectionStatus.update();
    if (!_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      Map<String, dynamic> customerResponseData = {};
      var _data = customerResponseModel.getKeys();
      _data.forEach((key) {
        final newEntries = <String, dynamic>{key: customerResponseModel.read(key)};
        customerResponseData.addEntries(newEntries.entries);
      });
      if (customerResponseData.length > 0) {
        return CustomerResponseModel.fromJson(customerResponseData);
      } else {
        return CustomerResponseModel(status: false);
      }
    } else {
      final response = await getHttp(getAllClientURL, token: token);
      if (response.responseCodeError == null) {
        Map<String, dynamic> fetchedData = response.data;
        List<String> fetchedDataKeys = fetchedData.keys.toList();
        fetchedDataKeys.forEach((keys) async {
          await customerResponseModel.write(keys, fetchedData[keys]);
        });
        return CustomerResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        box.erase();
        userdata.erase();
        Get.offAll(() => AuthPage());
        return CustomerResponseModel(status: false);
      } else {
        return CustomerResponseModel(status: false);
      }
    }
  }

  // get client location
  Future<LocationResponseModel?> getClientLocation({required String clientId}) async {
    var token = box.read('token');
    final response = await getHttp(getClientLocaionUrl + '?clientId=$clientId', token: token);
    if (response.responseCodeError == null) {
      return LocationResponseModel.fromJson(response.data);
    } else {
      return LocationResponseModel(status: false);
    }
  }

  ///Update location
  Future<UpdateLocationResponseModel?> updateClientLocation({required int locationId, required String name, required String description}) async {
    var token = box.read('token');
    final response = await putHttp("/FieldScientistAnalysisNesrea/Update-a-client-sample-location?SampleLocationId=$locationId&Name=$name&Description=$description", null, token: token);
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
    final response = await deleteHttp(addClientLocationURL + '$locationId', token: token);
    if (response.responseCodeError == null) {
      return jsonDecode(response.data);
    } else {
      return jsonDecode(response.data);
    }
  }

  // add sample point or client location
  Future<AddLocationResponseModel?> addClientLocation(AddLocationRequestModel model) async {
    var token = box.read('token');
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      final response = await postHttp(addClientLocationURL, model.toJson(), token: token);
      if (response.responseCodeError == null) {
        return AddLocationResponseModel.fromJson(response.data);
      } else {
        return AddLocationResponseModel(status: false);
      }
    } else {
      await PamsDatabaseHelpers.insert(db, addClientLocationURL, model.toJson(), token: token, category: 'ClientLocation');
      Fluttertoast.showToast(msg: 'Sample point has been stored locally in offline mode.');
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
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      var postObj = {'Id': Id, 'DPRFieldId': DPRFieldId, 'TestLimit': TestLimit, 'TestResult': TestResult};
      final response = await postHttp(addDPRTestForEach, postObj, token: token, formdata: true);
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      await EachTestData.insert(Id, DPRFieldId, null, null, TestLimit, TestResult, '1');
      Fluttertoast.showToast(msg: 'DPR Test stored locally');
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //submit DPR Template
  Future<RunSimpleTestResponseModel> submitDPRTestTemplate({required int samplePtId, required int DPRFieldId, required dynamic Latitude, required dynamic Longitude, required dynamic DPRTemplates, required String Picture}) async {
    var token = box.read('token');
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      String fileName = Picture.split('/').last;
      var _picture = await multipart.MultipartFile.fromFile(Picture, filename: fileName, contentType: MediaType('image', 'jpg'));
      var postObj = {'samplePtId': samplePtId, 'DPRFieldId': DPRFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'DPRTemplates': DPRTemplates, 'Picture': _picture};
      final response = await postHttp(submitDPRTemplate, postObj, token: token, formdata: true);
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      var postObj = {'samplePtId': samplePtId, 'DPRFieldId': DPRFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'DPRTemplates': DPRTemplates, 'Picture': Picture};
      await PamsDatabaseHelpers.insert(db, submitDPRTemplate, postObj, token: token, formdata: true, category: 'DPRTestTemplate');
      Fluttertoast.showToast(msg: 'DPR Template has been stored locally in offline mode.');
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
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      var postObj = {};
      final response = await postHttp(
        addFMENVTestForEach + '?Id=$Id&FMEnvFieldId=$FMEnvFieldId&TestLimit=$TestLimit&TestResult=$TestResult',
        postObj,
        token: token,
      );
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      await EachTestData.insert(Id, null, FMEnvFieldId, null, TestLimit, TestResult, '2');
      Fluttertoast.showToast(msg: 'FMENV Test stored locally');
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //submit FMENV Template
  Future<RunSimpleTestResponseModel> submitFMENVTestTemplate({required int samplePtId, required int FMEnvFieldId, required dynamic Latitude, required dynamic Longitude, required dynamic FMENVTemplates, required String Picture}) async {
    var token = box.read('token');
    await ConnectionStatus.update();

    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      String fileName = Picture.split('/').last;
      var _picture = await multipart.MultipartFile.fromFile(Picture, filename: fileName, contentType: MediaType('image', 'jpg'));
      var postObj = {'samplePtId': samplePtId, 'FMEnvFieldId': FMEnvFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'FMENVTemplates': FMENVTemplates, 'Picture': _picture};
      final response = await postHttp(submitFMENVTemplate, postObj, token: token, formdata: true);
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      var postObj = {'samplePtId': samplePtId, 'FMEnvFieldId': FMEnvFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'FMENVTemplates': FMENVTemplates, 'Picture': Picture};
      await PamsDatabaseHelpers.insert(db, submitFMENVTemplate, postObj, token: token, formdata: true, category: 'FMENVTestTemplate');
      Fluttertoast.showToast(msg: 'FMENV Template has been stored locally in offline mode.');
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
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      var postObj = {};
      final response = await postHttp(
        addNesreaTestForEach + '?Id=$Id&NesreaFieldId=$NesreaFieldId&TestLimit=$TestLimit&TestResult=$TestResult',
        postObj,
        token: token,
      );
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      await EachTestData.insert(Id, null, null, NesreaFieldId, TestLimit, TestResult, '3');
      Fluttertoast.showToast(msg: 'Nesrea Test stored locally');
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //submit Nesrea Template
  Future<RunSimpleTestResponseModel> submitNESREATestTemplate({required int samplePtId, required int NesreaFieldId, required dynamic Latitude, required dynamic Longitude, required dynamic NesreaTemplates, required String Picture}) async {
    var token = box.read('token');
    await ConnectionStatus.update();
    if (_controller.connectionStatus.value && !_controller.offlinePoint.value) {
      String fileName = Picture.split('/').last;
      var _picture = await multipart.MultipartFile.fromFile(Picture, filename: fileName, contentType: MediaType('image', 'jpg'));
      var postObj = {'samplePtId': samplePtId, 'NesreaFieldId': NesreaFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'NesreaTemplates': NesreaTemplates, 'Picture': _picture};
      final response = await postHttp(submitNESREATemplate, postObj, token: token, formdata: true);
      if (response.responseCodeError == null) {
        return RunSimpleTestResponseModel.fromJson(response.data);
      } else {
        return RunSimpleTestResponseModel(status: false);
      }
    } else {
      var postObj = {'samplePtId': samplePtId, 'NesreaFieldId': NesreaFieldId, 'Latitude': Latitude, 'Longitude': Longitude, 'NesreaTemplates': NesreaTemplates, 'Picture': Picture};
      await PamsDatabaseHelpers.insert(db, submitNESREATemplate, postObj, token: token, formdata: true, category: 'NESREATestTemplate');
      Fluttertoast.showToast(msg: 'NESREA Template has been stored locally in offline mode.');
      return RunSimpleTestResponseModel(status: false);
    }
  }

  //report screen

  //get dpr result activities

  Future<DprResultActivitiesModel?> getDPRResultActivities() async {
    var token = box.read('token');
    final response = await getHttp(getDPRResultActivityUrl, token: token);
    if (response.responseCodeError == null) {
      return DprResultActivitiesModel.fromJson(response.data);
    } else {
      return DprResultActivitiesModel(status: false);
    }
  }

  //get FMEnv result activities
  Future<FmenResultActivitiesModel?> getFMENVResultActivities() async {
    var token = box.read('token');
    final response = await getHttp(getFMENVResultActivityUrl, token: token);
    if (response.responseCodeError == null) {
      return FmenResultActivitiesModel.fromJson(response.data);
    } else {
      return FmenResultActivitiesModel(status: false);
    }
  }

  //get NESREA result activities
  Future<NesreaResultActivitiesModel?> getNESREAResultActivities() async {
    var token = box.read('token');
    final response = await getHttp(getNesreaResultActivityUrl, token: token);
    if (response.responseCodeError == null) {
      return NesreaResultActivitiesModel.fromJson(response.data);
    } else {
      return NesreaResultActivitiesModel(status: false);
    }
  }
}
