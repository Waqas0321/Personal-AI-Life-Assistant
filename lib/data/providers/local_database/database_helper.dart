import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/widgets/custom_toast_show.dart';
import '../../models/base_model.dart';
import 'databse_schema.dart';

class DatabaseHelper {
  ToastClass toast = ToastClass();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: DatabaseSchema.onCreate,
    );
  }
  /// Generic function to insert data into any table
  Future<int> insert<T extends BaseModel>(String table, T model) async {
    Database db = await database;
    return await db.insert(table, model.toMap());
  }

  /// Generic function to update data in any table
  Future<int> update<T extends BaseModel>(
      String table, T model, String whereColumn, List<dynamic> whereArgs) async {
    Database db = await database;
    /// Ensure `whereArgs` is not empty to prevent SQL errors
    if (whereArgs.isEmpty) {
      throw Exception("Error: `whereArgs` cannot be empty for update operation.");
    }
    return await db.update(
      table,
      model.toMap(),
      where: "$whereColumn = ?",
      whereArgs: whereArgs,
    );
  }


  /// Generic function to get data from any table
  Future<List<Map<String, dynamic>>> get(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    Database db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  /// Generic function to fetch a record by ID
  Future<Map<String, dynamic>?> getById(
      String table, String where, dynamic id) async {
    try {
      /// Use the existing `get` function to query the database
      List<Map<String, dynamic>> results = await get(
        table,
        where: '$where = ?',
        whereArgs: [id],
      );

      /// Check if a record was found
      if (results.isNotEmpty) {
        return results.first;
      } else {
        return null;
      }
    } catch (e) {
      /// Handle any errors
      log('Error fetching record by ID: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getListById(String table, String where, dynamic id) async {
    try {
      List<Map<String, dynamic>> results = await get(
        table,
        where: '$where = ?',
        whereArgs: [id],
      );

      return results;
    } catch (e) {
      log('Error fetching record by ID: $e');
      return [];
    }
  }



  /// Generic function to delete data from any table
  Future<int> delete(
      String table, String where, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.delete(
      table,
      where: "$where = ?",
      whereArgs: whereArgs,
    );
  }
}