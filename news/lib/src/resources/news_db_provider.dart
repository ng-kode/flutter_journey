import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  void init() async {
    // return the location of directory for app storage
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // join path to point to the db file
    final path = join(documentsDirectory.path, "items.db");

    // if path exists, open the db
    // else, create one
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """); // execute
      } // onCreate
    ); // openDatabase
  } // init

  Future<ItemModel> fetchItem(int id) async {
    // maps, similar to array of objects
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id], // whereArgs protect us from SQL injection attack
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMapForDb());
  }
}