
import 'package:mypack/utils/time.dart';

import 'database.dart';
import 'sqfl.dart';

class DatabaseColumnEntry extends DatabaseColumnFields implements ISqflEntry {
  @override
  final int id;
  @override
  String get table => super.table!;
  @override
  String get name => super.name!;
  @override
  DatabaseColumnType get type => super.type!;
  @override
  String get def => super.def!;
  @override
  bool get key => super.key!;
  @override
  bool get unique => super.unique!;

  DatabaseColumnEntry({
    required this.id,
    required super.name,
    required super.type,
    required super.table,
    required super.key,
    required super.unique,
    super.def,
  });

  @override
  String get entryNotes => "";

  @override
  int? get exportId => 0;

  @override
  int get lastModified => now.millisecondsSinceEpoch;

  DatabaseColumnEntry.fromTable(map)
      : id = map[DatabaseColumnTable.colId],
        super.fromTable(map);
}

class DatabaseColumnFields implements ISqflEntryFields {
  String? name;
  DatabaseColumnType? type;
  String? table;
  bool? key;
  bool? unique;
  String? reference;
  String? def;

  DatabaseColumnFields({
    this.name,
    this.type,
    this.table,
    this.key,
    this.unique,
    this.reference,
    this.def,
  });

  @override
  bool operator ==(covariant DatabaseColumnFields other) {
    if (identical(this, other)) return true;

    return other.name == name && other.table == other.table;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ key.hashCode ^ unique.hashCode;
  }

  DatabaseColumnFields.fromTable(Map<String, dynamic> map)
      : name = map[DatabaseColumnTable.colName],
        type = DatabaseColumnType.values.firstWhere(
            (e) => e.toString() == map[DatabaseColumnTable.colType]),
        key = IDatabaseTable.getBool(map[DatabaseColumnTable.colKey]),
        unique = IDatabaseTable.getBool(map[DatabaseColumnTable.colUnique]),
        reference = map[DatabaseColumnTable.colReference],
        table = map[DatabaseColumnTable.colTable],
        def = map[DatabaseColumnTable.colDef];

  @override
  Map<String, Object?> toTable() {
    return {
      DatabaseColumnTable.colName: name,
      DatabaseColumnTable.colType: type.toString(),
      if (key != null)
        DatabaseColumnTable.colKey: IDatabaseTable.getBoolInt(key ?? false),
      if (unique != null)
        DatabaseColumnTable.colUnique:
            IDatabaseTable.getBoolInt(unique ?? false),
      DatabaseColumnTable.colReference: reference,
      DatabaseColumnTable.colTable: table,
      DatabaseColumnTable.colDef: def,
    };
  }
}

class DatabaseColumnTable extends IDatabaseTable {
  static final DatabaseColumnTable _instance = DatabaseColumnTable._();
  factory DatabaseColumnTable() => _instance;

  static String get tableName => 'databaseColumn';
  static String get colId => 'id';
  static String get colName => 'name';
  static String get colType => 'type';
  static String get colKey => 'key';
  static String get colUnique => 'unique';
  static String get colReference => 'reference';
  static String get colTable => 'table';
  static String get colDef => 'def';

  DatabaseColumnTable._()
      : super(tableName, [
          DatabaseColumnFields(
              name: colId, type: DatabaseColumnType.int, key: true),
          DatabaseColumnFields(name: colName, type: DatabaseColumnType.str),
          DatabaseColumnFields(name: colType, type: DatabaseColumnType.en),
          DatabaseColumnFields(name: colKey, type: DatabaseColumnType.bool),
          DatabaseColumnFields(name: colUnique, type: DatabaseColumnType.bool),
          DatabaseColumnFields(
              name: colReference, type: DatabaseColumnType.str),
          DatabaseColumnFields(name: colTable, type: DatabaseColumnType.en),
          DatabaseColumnFields(name: colDef, type: DatabaseColumnType.str),
        ]);
}

class DatabaseColumnTypeTable extends IDatabaseTable {
  static final DatabaseColumnTypeTable _instance = DatabaseColumnTypeTable._();
  factory DatabaseColumnTypeTable() => _instance;

  static String get tableName => 'databaseColumnType';
  static String get colId => 'id';
  static String get colName => 'name';
  static String get colNice => 'nice';
  static String get colSqflite => 'sqflite';

  DatabaseColumnTypeTable._()
      : super(tableName, [
          DatabaseColumnFields(
              name: colId, type: DatabaseColumnType.int, key: true),
          DatabaseColumnFields(name: colName, type: DatabaseColumnType.str),
          DatabaseColumnFields(name: colNice, type: DatabaseColumnType.str),
          DatabaseColumnFields(name: colSqflite, type: DatabaseColumnType.str),
        ]);
}

enum DatabaseColumnType {
  int,
  str,
  dt,
  bool,
  en,
  ref,
  ;

  String get sqflite {
    switch (this) {
      case DatabaseColumnType.int:
        return 'INTEGER';
      case DatabaseColumnType.str:
        return 'TEXT';
      case DatabaseColumnType.dt:
        return 'INTEGER';
      case DatabaseColumnType.bool:
        return 'INTEGER';
      case DatabaseColumnType.en:
        return 'TEXT';
      case DatabaseColumnType.ref:
        return 'TEXT';
      default:
        return 'TEXT';
    }
  }

  String get nice {
    switch (this) {
      case DatabaseColumnType.int:
        return 'Integer';
      case DatabaseColumnType.str:
        return 'Text';
      case DatabaseColumnType.dt:
        return 'Date';
      case DatabaseColumnType.bool:
        return 'Boolean';
      case DatabaseColumnType.en:
        return 'Enumeration';
      case DatabaseColumnType.ref:
        return 'Reference';
      default:
        return 'NoneType';
    }
  }
}
