import 'package:fluttertoast/fluttertoast.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/services/client_service.dart';
import 'package:pams/utils/db.dart';

class SynchronizeData extends ApiManager {
  static var clientService = ClientServiceImplementation();
  static Future<void> init() async {
    Fluttertoast.showToast(msg: 'Syncing data...');
    await syncClientLocation();
    await syncDPRTestTemplate();
    await syncFMENVTestTemplate();
    await syncNESREATestTemplate();
    Fluttertoast.showToast(msg: 'Data sync successful.');
  }

  static Future syncClientLocation() async {
    var db = PamsDatabase.init();
    var clientLocations = await PamsDatabase.fetch(db, 'ClientLocation');
    if (clientLocations.length > 0) {
      clientLocations.forEach((clientLocation) async {
        var clientLocationData = await ClientLocationData.fetch(clientLocation['id'].toString());
        var response = await clientService.addClientLocation(
          AddLocationRequestModel(clientId: clientLocationData[0]['clientId'], name: clientLocationData[0]['name'], description: clientLocationData[0]['description']),
        );
        if (response!.status == true) {
          await PamsDatabase.delete(db, clientLocation['id']);
        }
      });
    }
  }

  static Future syncDPRTestTemplate() async {
    var db = PamsDatabase.init();
    var dprTestTemplates = await PamsDatabase.fetch(db, 'DPRTestTemplate');
    if (dprTestTemplates.length > 0) {
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
          await PamsDatabase.delete(db, dprTestTemplate['id']);
        }
      });
    }
  }

  static Future syncFMENVTestTemplate() async {
    var db = PamsDatabase.init();
    var fmenvTestTemplates = await PamsDatabase.fetch(db, 'FMENVTestTemplate');
    if (fmenvTestTemplates.length > 0) {
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
          await PamsDatabase.delete(db, fmenvTestTemplate['id']);
        }
      });
    }
  }

  static Future syncNESREATestTemplate() async {
    var db = PamsDatabase.init();
    var nesreaTestTemplates = await PamsDatabase.fetch(db, 'nesreaTestTemplate');
    if (nesreaTestTemplates.length > 0) {
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
          await PamsDatabase.delete(db, nesreaTestTemplate['id']);
        }
      });
    }
  }
}
