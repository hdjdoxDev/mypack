// ignore_for_file: prefer_final_fields

import 'package:mypack/utils/time.dart';

import 'database.dart';

abstract class ICsvEntry extends ICsvEntryFields {
  int _id = 0;
  String _entryNotes = "";
  int _lastModified;
  int? _exportId;

  int get id => _id;
  String get entryNotes => _entryNotes;
  int? get exportId => _exportId;
  int get lastModified => _lastModified;

  ICsvEntry.fromStringMap(Map<String, String> map)
      : _id = map[IDatabaseTable.colId] != null &&
                map[IDatabaseTable.colId]!.isNotEmpty
            ? int.parse(map[IDatabaseTable.colId]!)
            : 0,
        _entryNotes = map[IDatabaseTable.colEntryNotes] ?? "",
        _lastModified = map[IDatabaseTable.colLastModified] != null &&
                map[IDatabaseTable.colLastModified]!.isNotEmpty
            ? int.parse(map[IDatabaseTable.colLastModified]!)
            : now.millisecondsSinceEpoch,
        _exportId = int.tryParse(map[IDatabaseTable.colExportId] ?? ""),
        super.fromStringMap(map);

  ICsvEntry.fromCsv(String row)
      : _id = 0,
        _entryNotes = "",
        _lastModified = 0,
        _exportId = null,
        super.fromCsv(row);

  @override
  List<String> get csvHeaders => [
        IDatabaseTable.colId,
        ...super.csvHeaders,
        IDatabaseTable.colEntryNotes,
        IDatabaseTable.colLastModified,
        IDatabaseTable.colExportId,
      ];

  @override
  List<String> toStringList() => [
        id.toString(),
        ...super.toStringList(),
        entryNotes,
        exportId.toString(),
        lastModified.toString(),
      ];

  @override
  String toCsv() => toStringList().join(';');
}

abstract class ICsvEntryFields {
  List<String> get csvHeaders => [];
  ICsvEntryFields.fromStringMap(Map<String, String> map);
  ICsvEntryFields.fromCsv(String row);
  List<String> toStringList() => [];
  String toCsv() => toStringList().join(';');
}
