import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:walletin/database/table.dart';
import 'package:walletin/database/wallet.dart';

class Db {
  static const name = "dbWallet.db";
  static Database? _db;

  static Future<void> _init() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, name);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.query(
          "create table ${DbTable.name} "
          "(${DbTable.id} integer primary key, ${DbTable.note} text, "
          "${DbTable.createdAt} text, ${DbTable.updatedAt} text, "
          "${DbTable.type} text, ${DbTable.amount} text)",
        );
      },
    );
  }

  static Future<int> create({
    required ModelWallet data,
  }) async {
    if (_db == null) {
      await _init();
    }

    int result = await _db!.insert(
      DbTable.name,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result;
  }

  static Future<int> update({
    required ModelWallet data,
    required String id,
  }) async {
    if (_db == null) {
      await _init();
    }

    int result = await _db!.update(
      DbTable.name,
      data.toMap(),
      where: "${DbTable.id}=?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result;
  }

  static Future<int> delete({required String id}) async {
    if (_db == null) {
      await _init();
    }
    int result = await _db!.delete(
      DbTable.name,
      where: "${DbTable.id}=?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<List<Map<String, dynamic>>> read() async {
    if (_db == null) {
      await _init();
    }

    List<Map<String, dynamic>> map = await _db!.rawQuery(
      "select * from ${DbTable.name}",
    );

    return map;
  }
}
