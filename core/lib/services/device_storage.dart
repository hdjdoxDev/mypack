// import 'dart:async';
// import 'dart:io';

// import 'package:android_path_provider/android_path_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;

// enum StorageType { local, external, downloads, tmp, none }

// abstract class IDeviceStorage {}

// class DeviceStorage {
//   static late final DeviceStorage _instance;
//   static bool _instanceIsSet = false;

//   final String defaultPath;
//   final String downloadPath;
//   final String documentsPath;
//   final String localPath;
//   final String tmpPath;
//   final PermissionStatus permissionStatus;

//   DeviceStorage._({
//     required this.downloadPath,
//     required this.documentsPath,
//     required this.localPath,
//     required this.tmpPath,
//     required this.permissionStatus,
//   }) : defaultPath = localPath;

//   static Future<DeviceStorage> init() async {
//     if (_instanceIsSet == false) {
//       _instanceIsSet = true;
//       var permissionStatus = PermissionStatus.granted;
//       if (permissionStatus.isGranted) {
//         _instance = DeviceStorage._(
//           downloadPath: await getDownloadPath(),
//           documentsPath: await getDocumentsPath(),
//           localPath: await getLocalPath(),
//           tmpPath: await getTempPath(),
//           permissionStatus: permissionStatus,
//         );
//       } else {
//         _instance = DeviceStorage._(
//           downloadPath: "",
//           documentsPath: "",
//           localPath: "",
//           tmpPath: "",
//           permissionStatus: permissionStatus,
//         );
//       }
//     }
//     return _instance;
//   }

//   static Future<String> getDownloadPath() async {
//     if (Platform.isAndroid) {
//       return await AndroidPathProvider.downloadsPath;
//     } else if (Platform.isIOS) {
//       return (await getApplicationDocumentsDirectory()).path;
//     } else {
//       return (await getDownloadsDirectory())!.path;
//     }
//   }

//   static Future<String> getDocumentsPath() async {
//     if (Platform.isAndroid) {
//       return await AndroidPathProvider.documentsPath;
//     } else if (Platform.isIOS) {
//       return (await getApplicationDocumentsDirectory()).path;
//     } else {
//       return (await getApplicationDocumentsDirectory()).path;
//     }
//   }

//   static Future<String> getLocalPath() async {
//     return (await getApplicationDocumentsDirectory()).path;
//   }

//   static Future<String> getTempPath() async {
//     return (await getTemporaryDirectory()).path;
//   }

//   static Future<PermissionStatus> getPermissionStatus() async {
//     if (Platform.isAndroid) {
//       return Permission.storage.status;
//     } else if (Platform.isIOS) {
//       return Permission.storage.status;
//     } else if (Platform.isWindows) {
//       return Permission.storage.status;
//     } else if (Platform.isLinux) {
//       return PermissionStatus.granted;
//     } else {
//       return PermissionStatus.denied;
//     }
//   }

//   String rootDir(StorageType st) {
//     switch (st) {
//       case StorageType.local:
//         return localPath;
//       case StorageType.external:
//         return documentsPath;
//       case StorageType.downloads:
//         return downloadPath;
//       case StorageType.tmp:
//         return tmpPath;
//       case StorageType.none:
//         return defaultPath;
//     }
//   }

//   Future<bool> checkStatus() async {
//     if (permissionStatus.isGranted) {
//       return true;
//     }
//     // var res = await Permission.storage.request();
//     // if (res.isGranted) {
//     _instance = DeviceStorage._(
//       downloadPath: await getDownloadPath(),
//       documentsPath: await getDocumentsPath(),
//       localPath: await getLocalPath(),
//       tmpPath: await getTempPath(),
//       permissionStatus: PermissionStatus.granted,
//     );
//     return true;
//     // }
//     // return false;
//   }

//   // write file
//   Future<bool> writeFile({
//     String path = "",
//     required String name,
//     required String content,
//     StorageType st = StorageType.none,
//   }) async {
//     return checkStatus().then((value) async {
//       if (!value) return false;
//       final file = File(p.join(rootDir(st), path, name));
//       await file.writeAsString(content);
//       return true;
//     });
//   }

//   // read file
//   Future<String> readFile({
//     String path = "",
//     required String name,
//     StorageType st = StorageType.none,
//   }) =>
//       checkStatus().then((value) {
//         if (!value) return "";
//         final file = File(p.join(rootDir(st), path, name));
//         if (!file.existsSync()) {
//           print("file not found");
//           return "";
//         }
//         return file.readAsString();
//       });

//   // append to file
//   Future<bool> appendFile({
//     String path = "",
//     required String name,
//     required String content,
//     StorageType st = StorageType.none,
//   }) async =>
//       checkStatus().then((value) {
//         if (!value) return false;
//         final file = File(p.join(rootDir(st), path, name));
//         if (!file.existsSync()) {
//           file.createSync(recursive: true);
//         }
//         file.writeAsString(content, mode: FileMode.append);
//         return true;
//       });

//   // copy file
//   Future<bool> copyFile({
//     String pathfrom = "",
//     required String from,
//     required StorageType stfrom,
//     String pathto = "",
//     required String to,
//     StorageType stto = StorageType.none,
//   }) =>
//       checkStatus().then((value) {
//         if (!value) return false;
//         final filefrom = File(p.join(rootDir(stfrom), pathfrom, from));
//         if (!filefrom.existsSync()) {
//           return false;
//         }
//         final fileto = File(p.join(rootDir(stto), pathto, to));
//         if (!fileto.existsSync()) {
//           fileto.createSync(recursive: true);
//         }
//         filefrom.copySync(p.join(rootDir(stto), pathto, to));
//         return true;
//       });

//   // pick file from device
//   Future<String> pickFile({List<String>? extensions}) => FilePicker.platform
//       .pickFiles(
//           allowedExtensions: extensions,
//           type: extensions != null ? FileType.custom : FileType.any)
//       .then((result) async => result != null
//           ? await readFile(
//               st: StorageType.none, name: result.files.single.path!)
//           : "");

//   // save to download directory
//   Future<bool> downloadFile({required String name, required String content}) =>
//       writeFile(st: StorageType.downloads, name: name, content: content);
// }
