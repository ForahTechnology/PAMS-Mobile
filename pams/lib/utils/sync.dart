import 'package:fluttertoast/fluttertoast.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/services/client_service.dart';
import 'package:pams/utils/db.dart';
import 'package:pams/utils/db_helpers.dart';

class SynchronizeData extends ApiManager {
  static var clientService = ClientServiceImplementation();
  static Future<void> init() async {
    Fluttertoast.showToast(msg: 'Syncing data...');
    await syncClientLocation();
    await syncDPRTestTemplate();
    await syncFMENVTestTemplate();
    await syncNESREATestTemplate();
    await syncEACHTestData();
    Fluttertoast.showToast(msg: 'Data sync successful.');
  }

  static Future syncClientLocation() async {
    var db = PamsDatabase.init();
    var clientLocations = await PamsDatabaseHelpers.fetch(db, 'ClientLocation');
    if (clientLocations.length > 0) {
      clientLocations.forEach((clientLocation) async {
        var clientLocationData = await ClientLocationData.fetch(clientLocation['id'].toString());
        var response = await clientService.addClientLocation(
          AddLocationRequestModel(
            clientId: clientLocationData[0]['clientId'],
            name: clientLocationData[0]['name'],
            description: clientLocationData[0]['description'],
          ),
        );
        if (response!.status == true) {
          await PamsDatabaseHelpers.delete(db, clientLocation['id']);
        }
      });
    }
  }

  static Future syncDPRTestTemplate() async {
    var db = PamsDatabase.init();
    var dprTestTemplates = await PamsDatabaseHelpers.fetch(db, 'DPRTestTemplate');
    dprTestTemplates.forEach((dprTestTemplate) async {
      var dprTestTemplateData = await DPRTestTemplateData.fetch(dprTestTemplate['id'].toString());
      var response = await clientService.submitDPRTestTemplate(
        samplePtId: int.parse(dprTestTemplateData[0]['samplePtId']),
        DPRFieldId: int.parse(dprTestTemplateData[0]['DPRFieldId']),
        Latitude: dprTestTemplateData[0]['Latitude'],
        Longitude: dprTestTemplateData[0]['Longitude'],
        DPRTemplates: dprTestTemplateData[0]['DPRTemplates'],
        Picture: dprTestTemplateData[0]['Picture'],
      );
      if (response.status == true) {
        await PamsDatabaseHelpers.delete(db, dprTestTemplate['id']);
      }
    });
  }

  static Future syncFMENVTestTemplate() async {
    var db = PamsDatabase.init();
    var fmenvTestTemplates = await PamsDatabaseHelpers.fetch(db, 'FMENVTestTemplate');
    fmenvTestTemplates.forEach((fmenvTestTemplate) async {
      var fmenvTestTemplateData = await FMENVTestTemplateData.fetch(fmenvTestTemplate['id'].toString());
      var response = await clientService.submitFMENVTestTemplate(
        samplePtId: int.parse(fmenvTestTemplateData[0]['samplePtId']),
        FMEnvFieldId: int.parse(fmenvTestTemplateData[0]['FMENVFieldId']),
        Latitude: fmenvTestTemplateData[0]['Latitude'],
        Longitude: fmenvTestTemplateData[0]['Longitude'],
        FMENVTemplates: fmenvTestTemplateData[0]['FMENVTemplates'],
        Picture: fmenvTestTemplateData[0]['Picture'],
      );
      if (response.status == true) {
        await PamsDatabaseHelpers.delete(db, fmenvTestTemplate['id']);
      }
    });
  }

  static Future syncNESREATestTemplate() async {
    var db = PamsDatabase.init();
    var nesreaTestTemplates = await PamsDatabaseHelpers.fetch(db, 'NESREATestTemplate');
    nesreaTestTemplates.forEach((nesreaTestTemplate) async {
      var nesreaTestTemplateData = await NESREATestTemplateData.fetch(nesreaTestTemplate['id'].toString());
      var response = await clientService.submitNESREATestTemplate(
        samplePtId: int.parse(nesreaTestTemplateData[0]['samplePtId']),
        NesreaFieldId: int.parse(nesreaTestTemplateData[0]['NESREAFieldId']),
        Latitude: nesreaTestTemplateData[0]['Latitude'],
        Longitude: nesreaTestTemplateData[0]['Longitude'],
        NesreaTemplates: nesreaTestTemplateData[0]['NESREATemplates'],
        Picture: nesreaTestTemplateData[0]['Picture'],
      );
      if (response.status == true) {
        await PamsDatabaseHelpers.delete(db, nesreaTestTemplate['id']);
      }
    });
  }

  static Future syncEACHTestData() async {
    var eachTestData = await EachTestData.fetch();
    eachTestData.forEach((data) async {
      switch (data['Category']) {
        case '3':
          var response = await clientService.runEACHNESREATest(
            Id: int.parse(data['dataId']),
            NesreaFieldId: int.parse(data['NesreaFieldId']),
            TestLimit: data['TestLimit'],
            TestResult: data['TestResult'],
          );
          if (response.status == true) {
            await EachTestData.delete(data['dataId']);
          }
          break;
        case '2':
          var response = await clientService.runEACHFMENVTest(
            Id: int.parse(data['dataId']),
            FMEnvFieldId: int.parse(data['FMEnvFieldId']),
            TestLimit: data['TestLimit'],
            TestResult: data['TestResult'],
          );
          if (response.status == true) {
            await EachTestData.delete(data['dataId']);
          }
          break;
        default:
          var response = await clientService.runEACHDPRTest(
            Id: int.parse(data['dataId']),
            DPRFieldId: int.parse(data['DPRFieldId']),
            TestLimit: data['TestLimit'],
            TestResult: data['TestResult'],
          );
          if (response.status == true) {
            await EachTestData.delete(data['dataId']);
          }
      }
    });
  }
}
