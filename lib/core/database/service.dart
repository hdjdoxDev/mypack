import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'column/fields.dart';
import 'column/entry.dart';
import 'column/table.dart';
import 'table/entry.dart';
import 'table/fields.dart';
import 'table/table.dart';

class DatabaseTableSqflApi {
  DatabaseTableSqflApi._(this._db);

  static final tables = [tableTable, columnTable];
  static DatabaseTableTable tableTable = DatabaseTableTable();
  static DatabaseColumnTable columnTable = DatabaseColumnTable();

  static const _dbName = 'database_table.db';

  final Database _db;

  static Future<DatabaseTableSqflApi> init() =>
      getDatabasesPath().then((path) => openDatabase(
            p.join(path, _dbName),
            version: 1,
            onCreate: _onCreate,
          ).then((value) => DatabaseTableSqflApi._(value)));

  static Future<void> _onCreate(Database db, int version) async {
    if (version == 1) {
      for (var t in tables) {
        db.execute(t.createSqflite);
      }
    }
  }

  Future<void> insertTable(DatabaseTableFields tf) =>
      _db.insert(tableTable.name, tf.toTable(),
          conflictAlgorithm: ConflictAlgorithm.replace);

  Future<List<DatabaseTableEntry>> loadTables() =>
      _db.query(tableTable.name).then((value) =>
          value.map((e) => DatabaseTableEntry.fromTable(e)).toList());

  Future updateTable(int? id, DatabaseTableFields tableFields) =>
      _db.update(tableTable.name, tableFields.toTable(),
          where: "id = ?", whereArgs: [id]);

  Future insertField(String t, DatabaseColumnFields tff) =>
      _db.insert(columnTable.name, {"table": t, ...tff.toTable()},
          conflictAlgorithm: ConflictAlgorithm.replace);

  Future<List<DatabaseColumnEntry>> getFields(String tableName) => _db
      .query(columnTable.name, where: "table = ?", whereArgs: [tableName]).then(
          (value) =>
              value.map((e) => DatabaseColumnEntry.fromTable(e)).toList());

  Future get(int i) => _db
      .query(columnTable.name, where: "id = ?", whereArgs: [i]).then((value) =>
          value.isEmpty ? null : DatabaseColumnEntry.fromTable(value.first));
}
