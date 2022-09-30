import 'package:pams/utils/db.dart';
import 'package:sqflite/sqflite.dart';

class PamsDatabaseHelpers extends PamsDatabase {
  static Future<void> insert(Future<Database> db, String route, Map<String, dynamic> body, {Map<String, dynamic>? params, bool formdata = false, bool formEncoded = false, dynamic token, required String category}) async {
    var _db = await db;
    int _id;
    _id = await _db.rawInsert('INSERT INTO PostHttp(route, params, formdata, formEncoded, token, category) VALUES("$route", "$params", "$formdata", "$formEncoded", "$token", "$category")');
    switch (category) {
      case 'ClientLocation':
        await ClientLocationData.insert(_id, body);
        break;
      case 'DPRTestTemplate':
        await DPRTestTemplateData.insert(_id, body);
        break;
      case 'FMENVTestTemplate':
        await FMENVTestTemplateData.insert(_id, body);
        break;
      case 'NESREATestTemplate':
        await NESREATestTemplateData.insert(_id, body);
        break;
      default:
        await ClientLocationData.insert(_id, body);
    }
  }

  static Future<List<Map<String, dynamic>>> fetch(Future<Database> db, String? category) async {
    var _db = await db;
    var _result;
    if (category == null)
      _result = await _db.rawQuery("SELECT * FROM PostHttp");
    else
      _result = await _db.rawQuery("SELECT * FROM PostHttp WHERE category = '$category'");
    return _result;
  }

  static Future<void> delete(Future<Database> db, int id) async {
    db.then((database) async {
      var val = await database.rawQuery("SELECT * FROM PostHttp WHERE id = '$id'");
      var category = val[0]['category'];
      switch (category) {
        case 'ClientLocation':
          await ClientLocationData.delete(id.toString());
          break;
        case 'DPRTestTemplate':
          await DPRTestTemplateData.delete(id.toString());
          break;
        case 'FMENVTestTemplate':
          await FMENVTestTemplateData.delete(id.toString());
          break;
        case 'NESREATestTemplate':
          await NESREATestTemplateData.delete(id.toString());
          break;
        default:
          await ClientLocationData.delete(id.toString());
      }
      await database.rawDelete("DELETE FROM PostHttp WHERE id = '$id'");
    });
  }
}

class ClientLocationData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO ClientLocationData(dataId, clientId, name, description) VALUES("$dataId", "${data['clientId']}", "${data['name']}", "${data['description']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM ClientLocationData WHERE dataId = '$dataId'");
    return _result;
  }

  static Future<void> delete(String dataId) async {
    db.then(
      (database) async => await database.rawDelete("DELETE FROM ClientLocationData WHERE dataId = '$dataId'"),
    );
  }
}

class DPRTestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO DPRTestTemplateData(dataId, samplePtId, DPRFieldId, Latitude, Longitude, DPRTemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['DPRFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['DPRTemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM DPRTestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }

  static Future<void> delete(String dataId) async {
    db.then(
      (database) async => await database.rawDelete("DELETE FROM DPRTestTemplateData WHERE dataId = '$dataId'"),
    );
  }
}

class FMENVTestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO FMENVTestTemplateData(dataId, samplePtId, FMENVFieldId, Latitude, Longitude, FMENVTemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['FMEnvFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['FMENVTemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM FMENVTestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }

  static Future<void> delete(String dataId) async {
    db.then(
      (database) async => await database.rawDelete("DELETE FROM FMENVTestTemplateData WHERE dataId = '$dataId'"),
    );
  }
}

class NESREATestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO NESREATestTemplateData(dataId, samplePtId, NESREAFieldId, Latitude, Longitude, NESREATemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['NesreaFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['NesreaTemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM NESREATestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }

  static Future<void> delete(String dataId) async {
    db.then(
      (database) async => await database.rawDelete("DELETE FROM NESREATestTemplateData WHERE dataId = '$dataId'"),
    );
  }
}

class EachTestData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(
    int Id,
    int? DPRFieldId,
    int? FMEnvFieldId,
    int? NesreaFieldId,
    dynamic TestLimit,
    dynamic TestResult,
    String Category,
  ) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO EACHTest(dataId, DPRFieldId, FMEnvFieldId, NesreaFieldId, TestLimit, TestResult, Category) VALUES("$Id", "$DPRFieldId", "$FMEnvFieldId", "$NesreaFieldId", "$TestLimit", "$TestResult", "$Category")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch() async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM EACHTest");
    return _result;
  }

  static Future<void> delete(String dataId) async {
    db.then(
      (database) async => await database.rawDelete("DELETE FROM EACHTest WHERE dataId = '$dataId'"),
    );
  }
}
