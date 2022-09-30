import 'package:sqflite/sqflite.dart';

abstract class PamsDatabase {
  static Future<Database> init() async {
    var db = await openDatabase(
      'pamsDatabase.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""CREATE TABLE 
        PostHttp (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, route VARCHAR NULL, params VARCHAR NULL, formdata DOUBLE NULL, formEncoded BOOLEAN NULL, token VARCHAR NULL, category VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        ClientLocationData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, clientId VARCHAR NULL, name VARCHAR NULL, description VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        DPRTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, DPRFieldId VARCHAR NOT NULL, Latitude VARCHAR NULL, Longitude VARCHAR NULL, DPRTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        FMENVTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, FMENVFieldId VARCHAR NOT NULL, Latitude VARCHAR NULL, Longitude VARCHAR NULL, FMENVTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        NESREATestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, NESREAFieldId VARCHAR NOT NULL, Latitude VARCHAR NULL, Longitude VARCHAR NULL, NESREATemplates VARCHAR NULL, Picture VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        EACHTest (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, DPRFieldId VARCHAR NULL, FMEnvFieldId VARCHAR NULL, NesreaFieldId VARCHAR NULL, TestLimit VARCHAR NULL, TestResult VARCHAR NULL, Category VARCHAR NULL)""");
      },
    );
    return db;
  }
}
