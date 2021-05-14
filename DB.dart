import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'QR.dart';


class FoodDB {
  static Database database;

  // Initialize database
  static Future<Database> initDatabase() async {
    database = await openDatabase(
      // Ensure the path is correctly for any platform
      join(await getDatabasesPath(), "Food_database.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE Food(id INTEGER PRIMARY KEY,name TEXT,rest TEXT,cost INTEGER,protein INTEGER)");
      },

      // Version
      version: 1,
    );

    return database;
  }


  // Check database connected
  static Future<Database> getDatabaseConnect() async {
    if (database != null) {
      return database;
    }
    else {
      return await initDatabase();
    }
  }

  // Show all data
  static Future<List<food>> showAllData(int i) async {
    final Database db = await getDatabaseConnect();
    final List<Map<String, dynamic>> maps = await db.query("Food");

    return List.generate(i, (i) {
      return food(
        id: maps[i]["id"],
        name: maps[i]["name"],
        rest: maps[i]["rest"],
        cost: maps[i]["cost"],
        protein: maps[i]["protein"],
      );
    });
  }





  // Insert
  static Future<void> insertData(food Food) async {
    final Database db = await getDatabaseConnect();
    await db.insert(
      "Food",
      Food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update
  static Future<void> updateData(food Food) async {
    final db = await getDatabaseConnect();
    await db.update(
      "Food",
      Food.toMap(),
      where: "id = ?",
      whereArgs: [Food.id],
    );
  }

  // Delete
  static Future<void> deleteData(int id) async {
    final db = await getDatabaseConnect();
    await db.delete(
      "Food",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}