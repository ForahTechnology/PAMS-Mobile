import 'dart:io';

import 'package:pams/samples/data/microbial/data_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  Database? _database;

  Future<Database> get database async => _database ??= await initDataBase();

  Future<Database> initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'microbial.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE microbial(
      id INTEGER PRIMARY KEY,
      name TEXT,
      result TEXT,
      unit TEXT,
      testlimit TEXT,
      method TEXT
    )
    ''');
  }

  //get microbial data list
  Future<List<MicroBial>> getMicrobial() async {
    Database db = await instance.database;
    var microbial = await db.query(
      'microbial',
    );
    List<MicroBial> dataList = microbial.isNotEmpty
        ? microbial.map((e) => MicroBial.fromMap(e)).toList()
        : [];
    return dataList;
  }

  //add item to microbial list
  Future<int> add(MicroBial microBial) async {
    Database db = await instance.database;
    return await db.insert('microbial', microBial.toMap());
  }
    
  //remove item from microbial list
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('microbial', where: 'id = ?', whereArgs: [id]);
  }

  //update item on the microbial list
  Future<int> updateItem(MicroBial microbial) async {
    Database db = await instance.database;
    return await db.update('microbial', microbial.toMap(),
        where: 'id = ?', whereArgs: [microbial.id]);
  }
}
