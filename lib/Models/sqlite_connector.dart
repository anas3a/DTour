import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteConnector {
  static const dbname = 'dtourdb.db';
  static const dbVer = 1;
  static const userTableName = 'users';
  static const historyTableName = 'history';

  static Database? database;

  static Future<void> init() async {
    if (database != null) return;
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbname);
    database = await openDatabase(path, version: dbVer, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int ver) async {
    String query1 =
        'CREATE TABLE $userTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, email STRING, password STRING)';
    String query2 =
        'CREATE TABLE $historyTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, userEmail STRING, destination STRING, totalPerson INTEGER, startDate STRING, endDate STRING, hotelType STRING, transportationMode STRING, totalCost INTEGER)';
    await db.execute(query1);
    await db.execute(query2);
  }

  static Future<int> insert(String table, var data) async {
    return await database!.insert(table, data.toJson());
  }

  static Future<List<Map<String, dynamic>>> historyByEmail(
      String table, String? email) async {
    return database!
        .rawQuery("SELECT * FROM '$table' WHERE userEmail = '$email'");
  }

  static Future<List<Map<String, dynamic>>> getUserByEmail(
      String table, String? email) async {
    return database!.rawQuery("SELECT * FROM '$table' WHERE email = '$email'");
  }

  static Future<List<Map<String, dynamic>>> getUserByEmailAndPassword(
      String table, String? email, String? password) async {
    return database!.rawQuery(
        "SELECT * FROM '$table' WHERE email = '$email' AND password = '$password'");
  }
}
