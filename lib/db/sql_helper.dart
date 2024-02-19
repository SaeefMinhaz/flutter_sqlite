import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{

  /// create table
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        product_id INTEGER
    )
    """);
  }

  /// create db for the first time
  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'trstore.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        print("... creating a table");
        await createTables(database);
      },
    );
  }

  /// create item in db
  static Future<int> createItem(String title, String? description, int productId) async{
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': description, 'product_id': productId};
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  /// fetch all items
  static Future<List<Map<String, dynamic>>> getItems() async{
    final db = await SQLHelper.db();
    return db.query('items', orderBy:"id");
  }

  /// fetch single item
  static Future<List<Map<String, dynamic>>> getItem(int id) async{
    final db = await SQLHelper.db();
    return db.query('items', where: "product_id = ?",  whereArgs: [id], limit: 1);
  }

  /// update single item
  static Future<int> updateItem(
      int id, String title, String? description) async{
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      // 'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }


  /// delete single item
 static Future<void> deleteItem(int id) async{
    final db = await SQLHelper.db();
    try{
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch(err){
      debugPrint("Something went wrong when deleting the item: $err");
    }
 }


}