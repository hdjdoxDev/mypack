

import 'package:mypack/utils/time.dart';

import '../entry/model.dart';
import 'table.dart';

class DatabaseTableFields implements IFields {
  String? name;
  DateTime? created;

  DatabaseTableFields({
    required this.name,
    required this.created,
  });

  // @override
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
  

  @override
  DatabaseTableFields update(fields) {
    if (fields is DatabaseTableFields) {
      
    }
    return this;
  }
}
