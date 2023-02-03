// ignore_for_file: prefer_final_fields

mixin IEntry {
  final _id = 0;
  String _entryNotes = "";
  int _lastModified = 0;
  int? _exportId;

  int get id => _id;
  String get entryNotes => _entryNotes;
  int get lastModified => _lastModified;
  int? get exportId => _exportId;

  get fields;
}

mixin IEntryFields {}
