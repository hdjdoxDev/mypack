
import 'package:mypack/utils/time.dart';
import 'database.dart';
import 'database_column.dart';
import 'sqfl.dart';

class DatabaseTableEntry extends DatabaseTableFields
    implements ISqflEntryFields {
  final int id;

  DatabaseTableEntry({
    required this.id,
    required String name,
    required DateTime created,
  }) : super(name: name, created: created);

  DatabaseTableEntry.fromTable(Map<String, dynamic> map)
      : id = map[IDatabaseTable.colId],
        super.fromTable(map);

  @override
  Map<String, Object?> toTable() => {
        IDatabaseTable.colId: id,
        ...super.toTable(),
      };
}

class DatabaseTableFields implements ISqflEntryFields {
  String? name;
  DateTime? created;

  DatabaseTableFields({
    required this.name,
    required this.created,
  });

  @override
  Map<String, Object?> toTable() {
    return {
      DatabaseTableTable.colName: name,
      DatabaseTableTable.colDateCreated: created?.millisecondsSinceEpoch ?? now,
    };
  }

  DatabaseTableFields.fromTable(Map<String, dynamic> map)
      : name = map[DatabaseTableTable.colName],
        created = DateTime.fromMillisecondsSinceEpoch(
            map[DatabaseTableTable.colDateCreated]);
}

class DatabaseTableTable extends IDatabaseTable {
  static String get tableName => "tables";
  static String get colName => "name";
  static String get colDateCreated => "dateCreated";
  static DatabaseTableTable instance = DatabaseTableTable._();
  factory DatabaseTableTable() => instance;
  DatabaseTableTable._() 
      : super(tableName, [
          DatabaseColumnFields(name: colName, type: DatabaseColumnType.str),
          DatabaseColumnFields(
              name: colDateCreated, type: DatabaseColumnType.dt),
        ]);
}
