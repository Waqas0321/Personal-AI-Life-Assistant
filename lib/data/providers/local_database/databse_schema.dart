import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'databse_constants.dart';

class DatabaseSchema {
  static Future<void> onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE ${DatabaseConstants.tasksTable} (
          ${DatabaseConstants.columnTaskId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DatabaseConstants.columnTaskTitle} TEXT NOT NULL,
          ${DatabaseConstants.columnTaskStartTime} TEXT NOT NULL,
          ${DatabaseConstants.columnTaskEndTime} TEXT NOT NULL,
          ${DatabaseConstants.columnTaskCategory} TEXT NOT NULL,
          ${DatabaseConstants.columnUserId} TEXT NOT NULL
        )
      ''');
    } catch (e) {
      log('Error creating database: $e');
    }
  }
}
