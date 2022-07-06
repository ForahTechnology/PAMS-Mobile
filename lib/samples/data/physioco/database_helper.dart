import 'dart:io';
import 'package:pams/samples/data/physioco/data_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PhysicoDataBaseHelper {
  PhysicoDataBaseHelper._privateConstructor();
  static final PhysicoDataBaseHelper instance =
      PhysicoDataBaseHelper._privateConstructor();
  Database? _database;

  Future<Database> get database async => _database ??= await initDataBase();

  Future<Database> initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'physiCo.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE PhysiCo(
      id INTEGER PRIMARY KEY,
      name TEXT,
      result TEXT,
      uc TEXT,
      testlimit TEXT,
      method TEXT
    )
    ''');
  }

  //get PhysiCo data list
  Future<List<PhysiCo>> getPhysiCo() async {
    Database db = await instance.database;
    var physiCo = await db.query(
      'physiCo',
    );
    List<PhysiCo> dataList = physiCo.isNotEmpty
        ? physiCo.map((e) => PhysiCo.fromMap(e)).toList()
        : [];
    return dataList;
  }

  //add item to PhysiCo list
  Future<int> add(PhysiCo physiCo) async {
    Database db = await instance.database;
    return await db.insert('physiCo', physiCo.toMap());
  }

  //remove item from PhysiCo list
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('physiCo', where: 'id = ?', whereArgs: [id]);
  }

  //update item on the PhysiCo list
  Future<int> updateItem(PhysiCo physiCo) async {
    Database db = await instance.database;
    return await db.update('physiCo', physiCo.toMap(),
        where: 'id = ?', whereArgs: [physiCo.id]);
  }

  //close db
  Future close() async {
    Database db = await instance.database;
    return await db.close();
  }
}
