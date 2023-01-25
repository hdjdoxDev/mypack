// ignore_for_file: prefer_final_fields

import 'entry.dart';
import 'database.dart';

abstract class ISqflEntryFields {
  ISqflEntryFields.fromTable(Map<String, dynamic> map);
  Map<String, Object?> toTable() => {};
}

abstract class ISqflEntry extends ISqflEntryFields implements IEntry {
  final int _id;
  String _entryNotes = "";
  int _lastModified;
  int? _exportId;

  @override
  int get id => _id;
  @override
  String get entryNotes => _entryNotes;
  @override
  int? get exportId => _exportId;
  @override
  int get lastModified => _lastModified;

  ISqflEntry.fromTable(Map<String, dynamic> map)
      : _id = map[IDatabaseTable.colId],
        _entryNotes = map[IDatabaseTable.colEntryNotes],
        _lastModified = map[IDatabaseTable.colLastModified],
        _exportId = map[IDatabaseTable.colExportId],
        super.fromTable(map);

  @override
  Map<String, Object?> toTable() => {
        IDatabaseTable.colId: id,
        ...super.toTable(),
        IDatabaseTable.colEntryNotes: entryNotes,
        IDatabaseTable.colLastModified: lastModified,
        IDatabaseTable.colExportId: exportId,
      };
}
